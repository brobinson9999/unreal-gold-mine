class SampleScrapCollectorController extends AIController;

var float PauseTime;
var NavigationPoint OldMoveTarget;
var SampleScrap scrapTarget;

function BumpTimer()
{
  enable('NotifyBump');
}

event bool NotifyBump(Actor Other, Vector HitNormal)
{
  local Pawn P;

  Disable('NotifyBump');
  SetTimer(1.0, false, 'BumpTimer');

  P = Pawn(Other);
  if ( (P == None) || (P.Controller == None) )
    return false;

  AdjustAround(P);
  return false;
}

function AdjustAround(Pawn Other)
{
  local vector VelDir, OtherDir, SideDir;

  if ( !InLatentExecution(LATENT_MOVETOWARD) )
    return;

  VelDir = Normal(MoveTarget.Location - Pawn.Location);
  VelDir.Z = 0;
  OtherDir = Other.Location - Pawn.Location;
  OtherDir.Z = 0;
  OtherDir = Normal(OtherDir);
  if ( (VelDir Dot OtherDir) > 0.7 )
  {
    bAdjusting = true;
    SideDir.X = VelDir.Y;
    SideDir.Y = -1 * VelDir.X;
    if ( (SideDir Dot OtherDir) > 0 )
      SideDir *= -1;
    AdjustLoc = Pawn.Location + 3 * Other.GetCollisionRadius() * (0.5 * VelDir + SideDir);
  }
}

auto state Mining
{
  ignores SeePlayer, SeeMonster;

  function tick(float delta) {
    if (scrapTarget != none && vsize(scrapTarget.location - pawn.location) < 100) {
      scrapTarget.destroy();
      scrapTarget = none;
      routeGoal = none;
      GotoState('Mining', 'Finished');
    }
    
    global.tick(delta);
  }
  
  function Actor findNearest(class<Actor> actorClass) {
    local Actor this, best;
    local float thisDistance, bestDistance;
    
    foreach dynamicActors(actorClass, this) {
      thisDistance = vsize(this.location - pawn.location);
      if (thisDistance < bestDistance || best == none) {
        best = this;
        bestDistance = thisDistance;
      }
    }
    
    return best;
  }
  
  function FindPath()
  {
    local SampleScrapCollector P;
    local NavigationPoint PreviousMoveTarget;

    P = SampleScrapCollector(Pawn);
    scrapTarget = SampleScrap(findNearest(class'SampleScrap'));
//    RouteGoal = P.bIsCarryingOre ? P.Home : P.Home.Mine;

    `log("searching for path: routeGoal: "$routeGoal);

    if ( scrapTarget == None )
      return;

    routeGoal = scrapTarget;

    if ( MoveTarget != RouteGoal )
      PreviousMoveTarget = NavigationPoint(MoveTarget);

//    if ( P.ReachedDestination(RouteGoal) )
//    {
//      `log("reached destination - pausing");
//      PauseTime = P.bIsCarryingOre ? 2 : 6;
//      GotoState('Mining', 'Pause');
//      return;
//    }

    MoveTarget = FindPathToward(RouteGoal,false);
    `log("searching for path: moveTarget: "$moveTarget);

/*
    if ( MoveTarget == None )
    {
      `log("reverting to oldMoveTarget: "$oldMoveTarget);

      if ( OldMoveTarget != None )
      {
        MoveTarget = OldMoveTarget;
        OldMoveTarget = None;
      }
      return;
    }
    if ( PreviousMoveTarget != None )
      OldMoveTarget = PreviousMoveTarget;*/
  }

Begin:
  FindPath();
  if (routeGoal != none) {
    if (moveTarget != none)
      moveToward(MoveTarget);
    else
      moveTo(routeGoal.location);
  } else {
    moveTo(pawn.location);
  }

  sleep(pauseTime);
  Goto('Begin');
Pause:
  SampleScrapCollector(Pawn).StartWorking();
  Sleep(PauseTime);
Finished:
//  if ( SampleScrapCollector(Pawn).bIsCarryingOre )
//  {
//    SampleScrapCollector(Pawn).Home.ReceiveOre(SampleScrapCollector(Pawn).OreQuantity);
//  }
//  SampleScrapCollector(Pawn).SetCarryingOre(!SampleScrapCollector(Pawn).bIsCarryingOre);
  Goto('Begin');
}

defaultproperties
{
  pauseTime=0.5
}