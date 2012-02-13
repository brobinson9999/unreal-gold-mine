class InventoryGrenade extends Inventory;

simulated function postBeginPlay() {
      `log("grenade spawned");

  class'PlatformStatics'.static.installMutatorClassIfNotInstalled(self, class'GrenadeThrowingMutator');
  
  super.postBeginPlay();
}

simulated function throwGrenade(Pawn thrower) {
  
}

defaultproperties
{
}