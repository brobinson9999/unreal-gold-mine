class SampleGrenade extends InventoryGrenade;

var vector throwSpeed;

simulated function throwGrenade(Pawn thrower) {
  local SampleGrenadeProj g;
  
  g = thrower.spawn(class'SampleGrenadeProj', thrower.instigator,, thrower.location, thrower.desiredRotation);
  if (g != None)
    g.velocity = thrower.velocity + (throwSpeed >> thrower.controller.desiredRotation);
  
  super.throwGrenade(thrower);
}

defaultproperties
{
  throwSpeed=(x=100,y=10)
}