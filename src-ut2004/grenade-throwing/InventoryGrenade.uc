class InventoryGrenade extends Inventory;

simulated function postBeginPlay() {
  class'PlatformStatics'.static.installMutatorClassIfNotInstalled(self, class'GrenadeThrowingMutator');
  
  super.postBeginPlay();
}

simulated function throwGrenade(Pawn thrower) {
  
}

defaultproperties
{
}