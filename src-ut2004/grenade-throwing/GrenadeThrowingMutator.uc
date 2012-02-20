class GrenadeThrowingMutator extends Mutator cacheExempt;

simulated function mutate(string mutateString, PlayerController sender) {
  local array<string> msParts;
  local Inventory inventoryItem;
  
  msParts = class'PlatformStatics'.static.platformSplitString(mutateString, " ");
  
  if (msParts.length > 0 && msParts[0] ~= "throwGrenade") {
    if (sender.pawn != none) {
      for (inventoryItem = sender.pawn.inventory;inventoryItem != none;inventoryItem = inventoryItem.inventory) {
        if (InventoryGrenade(inventoryItem) != none) {
          InventoryGrenade(inventoryItem).throwGrenade(sender.pawn);
          break;
        }
      }
    }
  }

  super.mutate(mutateString, sender);
}

defaultproperties
{
  friendlyName="Grenade Throwing Mutator"
  description="Enables support for grenade throwing."
}