class SampleGrenade extends InventoryGrenade;

var vector throwSpeed;
var class<SampleGrenadeProj> grenadeProjClass;

simulated function throwGrenade(Pawn thrower) {
  local SampleGrenadeProj g;
  
  g = thrower.spawn(grenadeProjClass, thrower.instigator,, thrower.location, thrower.desiredRotation);
  if (g != None)
    g.velocity = thrower.velocity + (throwSpeed >> thrower.controller.desiredRotation);
  
  super.throwGrenade(thrower);
}

defaultproperties
{
  throwSpeed=(x=1000,z=200)
  grenadeProjClass=class'SampleGrenadeProj'
}