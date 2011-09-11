class SeqAct_EndGame extends SequenceAction;

// Player/Team object that should win
var() object winnerObject;

// Team number that should win, if winnerObject is none
var() int winnerTeamNum;

// Points awarded to winner automatically - can be needed if # of points will determine victor for the gametype irrespective of what is passed as "winner" to endGame()
var int bonusPoints;

event activated() {
  local GameInfo gameInfo;
  local Pawn winnerPawn;
  local Controller winnerController;
  local PlayerReplicationInfo winnerPRI;
  local PlayerReplicationInfo priIter;
  
  gameInfo = getWorldInfo().game;
  
  winnerPawn = Pawn(winnerObject);
  winnerController = Controller(winnerObject);
  winnerPRI = PlayerReplicationInfo(winnerObject);

  gameInfo.`log("kismet trying to end game");

  if (winnerPawn == none && winnerController == none && winnerPRI == none && UTTeamGame(gameInfo) != none) {
    gameInfo.`log("Trying to find a winner");
    foreach gameInfo.dynamicActors(class'PlayerReplicationInfo', priIter) {
      gameInfo.`log("Trying to find a winner - considering "$priIter$" w/ "$priIter.team$" vs "$UTTeamGame(gameInfo).teams[winnerTeamNum]);
      gameInfo.`log(priIter.team != none$" "$(priIter.team == UTTeamGame(gameInfo).teams[winnerTeamNum])$" "$(winnerPRI == none || winnerPRI.score < priIter.score));
      
      if (priIter.team != none && priIter.team == UTTeamGame(gameInfo).teams[winnerTeamNum] && (winnerPRI == none || winnerPRI.score < priIter.score)) {
        winnerPRI = priIter;
        gameInfo.`log("new winnerPRI: "$winnerPRI);
      }
    }
  }

  if (winnerController == none && winnerPawn != none)
    winnerController = winnerPawn.controller;

  if (winnerPRI == none && winnerController != none)
    winnerPRI = winnerController.playerReplicationInfo;

  gameInfo.`log(winnerPRI$" wants to trigger end of game.");

  if (winnerPRI != none) {
    gameInfo.`log(winnerPRI$" triggered end of game.");

    // in case winning player/team still has to have the higher score in order to win
    if (bonusPoints > 0) {
      if (winnerPRI.team != none) {
        winnerPRI.team.score += bonusPoints;
        winnerPRI.team.bForceNetUpdate = TRUE;
      } else {
        winnerPRI.score += bonusPoints;
      }
    }

    gameInfo.endGame(winnerPRI, "triggered");
  }
}

defaultproperties
{
  ObjName="End Game"
  ObjCategory="Actor"
  ObjClassVersion=2

  VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="WinnerObject",PropertyName=winnerObject)
  VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="WinnerTeamNum",PropertyName=winnerTeamNum)
  
  bonusPoints=0
}
