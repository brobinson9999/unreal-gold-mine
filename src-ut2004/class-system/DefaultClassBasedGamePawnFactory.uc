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
  local Inventory newInventory;
  
  other.health = health;
  other.healthMax = health;
  
  for (i=0;i<pawnInventory.length;i++) {
    newInventory = other.spawn(pawnInventory[i],,,other.location,other.rotation);
    newInventory.giveTo(other);
  }
}

defaultproperties
{
}