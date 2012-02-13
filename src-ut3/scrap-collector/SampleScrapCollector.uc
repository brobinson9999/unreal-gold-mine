class SampleScrapCollector extends GamePawn;

var UTOnslaughtTarydiumProcessor Home;
var staticmeshcomponent CarriedOre;
var repnotify bool bIsCarryingOre;
var repnotify bool bIsWorking;
var soundcue ExplosionSound;
var particlesystem ExplosionTemplate;

var float OreQuantity;

var UTOnslaughtNodeObjective ControllingNode;

replication
{
  if (bNetDirty)
    bIsCarryingOre, bIsWorking;
}

simulated function PostBeginPlay()
{
  Super.PostBeginPlay();

  CarriedOre.SetHidden(true);
  SpawnDefaultController();
}

simulated native function byte GetTeamNum();

simulated event ReplicatedEvent(name VarName)
{
  if ( VarName == 'bIsCarryingOre' )
  {
    SetCarryingOre(bIsCarryingOre);
  }
  else if (VarName == 'bIsWorking')
  {
    if (bIsWorking)
    {
      StartWorking();
    }
  }
  else
  {
    Super.ReplicatedEvent(VarName);
  }
}

simulated function SetCarryingOre(bool bNewValue)
{
  bIsWorking = false;
  bIsCarryingOre = bNewValue;
  CarriedOre.SetHidden(!bIsCarryingOre);
}

simulated function StartWorking()
{
  bIsWorking = true;
}

simulated function Destroyed()
{
  Super.Destroyed();

  if ( Home != None )
  {
    Home.MinerDestroyed();
  }

  // blow up
  if ( (WorldInfo.NetMode != NM_DedicatedServer) && (ExplosionTemplate != None) && EffectIsRelevant(Location,false,5000) )
  {
    WorldInfo.MyEmitterPool.SpawnEmitter(ExplosionTemplate, Location, Rotation);
  }

  if (ExplosionSound != None)
  {
    PlaySound(ExplosionSound, true);
  }
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
  if ( Controller != None )
    Controller.Destroy();
  Destroy();
}

defaultproperties
{
  // all default properties are located in the _Content version for easier modification and single location
}
