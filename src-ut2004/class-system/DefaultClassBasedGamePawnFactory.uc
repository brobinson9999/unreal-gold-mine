class DefaultClassBasedGamePawnFactory extends ClassBasedGamePawnFactory;

var class<Pawn> pawnClass;
var int health;
var array< class< Inventory > > pawnInventory;

simulated function Pawn createPawn(GameInfo ginfo, vector startLocation, rotator startRotation) {
  local Pawn result;
  
  result = ginfo.spawn(pawnClass,,, startLocation, startRotation);

  // do this when called externally from modifyPlayer.
//  setPawnProperties(other);
  
  return result;
}

simulated function class<Pawn> getPawnClass() {
  return pawnClass;
}

simulated function setPawnProperties(Pawn other) {
  local int i;
  
  other.healthMax = health;
  
  if (!pawnHasInventory(other, class'InitialSetupToken')) {
    givePawnInventory(other, class'InitialSetupToken');

    other.health = health;

    for (i=0;i<pawnInventory.length;i++) {
      givePawnInventory(other, pawnInventory[i]);
    }
  }
}

simulated function bool pawnHasInventory(Pawn other, class<Inventory> inventoryClass) {
  local Inventory dummy;
  
  for (dummy = other.inventory;dummy != none;dummy = dummy.inventory) {
    if (classIsChildOf(dummy.class, inventoryClass))
      return true;
  }
    
  return false;
}

simulated function givePawnInventory(Pawn other, class<Inventory> inventoryClass) {
  local Inventory newInventory;

  newInventory = other.spawn(inventoryClass,,,other.location,other.rotation);
  newInventory.giveTo(other);
}

defaultproperties
{
}