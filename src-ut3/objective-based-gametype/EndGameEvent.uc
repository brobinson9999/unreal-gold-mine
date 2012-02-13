class EndGameEvent extends Triggerable placeable;

var() int teamNum;
var() string endGameEventName;

simulated function triggered(string eventName, object relevantObject) {
  local GameInfo gameIter;
  local Pawn winnerPawn;
  local Controller winnerController;
  local PlayerReplicationInfo winnerPRI;
  local PlayerReplicationInfo priIter;
  
  if (eventName == endGameEventName) {
    winnerPawn = Pawn(relevantObject);
    winnerController = Controller(relevantObject);
    winnerPRI = PlayerReplicationInfo(relevantObject);

    if (winnerPawn == none && winnerController == none && winnerPRI == none) {
      `log("Trying to find a winner");
      foreach dynamicActors(class'PlayerReplicationInfo', priIter) {
        `log("Trying to find a winner - considering "$priIter$" w/ "$priIter.team.teamIndex$" vs "$teamNum);
        if (priIter.team != none && priIter.team.teamIndex == teamNum) {
          winnerPRI = priIter;
          break;
        }
      }
    }

    if (winnerController == none && winnerPawn != none)
      winnerController = winnerPawn.controller;

    if (winnerPRI == none && winnerController != none)
      winnerPRI = winnerController.playerReplicationInfo;

    `log(relevantObject$" wants to trigger end of game.");

    if (winnerPRI != none)
      foreach dynamicActors(class'GameInfo', gameIter) {
        `log(relevantObject$" triggered end of game.");
        gameIter.endGame(winnerPRI, "triggered");
      }
  }

  super.triggered(eventName, relevantObject);
}

defaultproperties
{
}
