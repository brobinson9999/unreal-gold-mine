class PawnFactory extends Triggerable;

var() int pawnAISkill;
var() int teamNum;
var() class<Pawn> pawnClass;
var() array< class<Inventory> > spawnWithInventory;
var() string spawnEventName;
var() string pawnFriendlyName;

simulated function triggered(string eventName, object relevantObject) {
  if (eventName == spawnEventName)
    spawnPawn();
}

simulated function spawnPawn() {
  local int i;
  local Pawn newPawn;
  local Controller newPawnController;
  local UTPlayerReplicationInfo newPawnPRI;
  local UTTeamInfo newPawnTeam;

  newPawn = spawn(pawnClass);
  
  if (newPawn != none) {
    newPawn.spawnDefaultController();
    newPawnController = newPawn.controller;

    if (newPawnController != none) {
      newPawnPRI = UTPlayerReplicationInfo(newPawnController.playerReplicationInfo);
      if (newPawnPRI != none) {
        newPawnPRI.setPlayerName(pawnFriendlyName);
      }
      
      if (UTBot(newPawnController) != none) {
        UTBot(newPawnController).skill = pawnAISkill;
      }
      
      if (UTTeamGame(worldInfo.game) != none) {
        newPawnTeam = UTTeamGame(worldInfo.game).teams[teamNum];
        newPawnTeam.addToTeam(newPawnController);
        newPawnTeam.setBotOrders(UTBot(newPawnController));
      }
    }

    for (i=0;i<spawnWithInventory.length;i++)
      giveInventoryItem(newPawn, spawnWithInventory[i], true);
  }
}

function giveInventoryItem(Pawn other, class<Inventory> inventoryClass, bool bActivate)
{
  // Ensure we don't give duplicate items
  if (other.findInventoryType(inventoryClass) == none) {
    other.createInventory(inventoryClass, !bActivate);
  }
}

defaultproperties
{
  pawnAISkill=3
  pawnFriendlyName="someone"
}
