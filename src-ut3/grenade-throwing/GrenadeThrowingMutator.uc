class GrenadeThrowingMutator extends UTMutator;

simulated function postBeginPlay() {
 `log("grenade mut spawned");
  super.postBeginPlay();
}

simulated function mutate(string mutateString, PlayerController sender) {
  local array<string> msParts;
  local InventoryGrenade inventoryGrenade;
  
  msParts = class'PlatformStatics'.static.platformSplitString(mutateString, " ");
  
  if (msParts.length > 0 && msParts[0] ~= "throwGrenade") {
    if (sender.pawn != none) {
      foreach sender.pawn.invManager.inventoryActors(class'InventoryGrenade', inventoryGrenade) {
        inventoryGrenade.throwGrenade(sender.pawn);
        break;
      }
    }
  }

  super.mutate(mutateString, sender);
}

defaultproperties
{
  // don't show this in the mutator selection menu
  bExportMenuData=false
}