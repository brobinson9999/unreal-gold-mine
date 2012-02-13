class MutPlayerFlight extends Mutator;

var float rangeFactor;
var array< class<Actor> > monsterProjectileClasses;

function startFlying(Pawn pawn) {
  log(pawn$" startFlying");
  
  pawn.bCanFly = true;
  
  if (PlayerController(pawn.controller) != none) {
    PlayerController(pawn.controller).gotoState('PlayerFlying');
  }
}

function stopFlying(Pawn pawn) {
  log(pawn$" stopFlying");

  pawn.bCanFly = false;
  
  pawn.setPhysics(PHYS_Walking);

  if (PlayerController(pawn.controller) != none) {
    PlayerController(pawn.controller).clientRestart(pawn);
  }
}

function tick(float delta) {
  local Pawn pawn;
  
  foreach dynamicActors(class'Pawn', pawn) {
    if (pawn.physics == PHYS_Falling && (pawn.velocity.z > 0 || fastTrace(pawn.location, pawn.location + vect(0,0,-150))))
      startFlying(pawn);
    else if (pawn.physics == PHYS_Flying && pawn.velocity.z < 0 && !fastTrace(pawn.location, pawn.location + vect(0,0,-100))) {
      stopFlying(pawn);
    }
  }
      
  super.tick(delta);
}

defaultproperties
{
  iconMaterialName="MutatorArt.nosym"
  configMenuClassName=""
  groupName=""
  friendlyName="Player Flight"
  description="Players can fly and land."
}