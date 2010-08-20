class ObjectiveGameInfo extends UTTeamGame;

function bool wantsPickups(UTBot B) {
  return false;
}

function class<Pawn> getDefaultPlayerClass(Controller c) {
  local UTUL_ClassBasedGameMutator cbgm;
  local class<Pawn> cbgmResult;
  
  foreach dynamicActors(class'UTUL_ClassBasedGameMutator', cbgm) {
    cbgmResult = cbgm.getPawnClassForPlayer(c);
    if (cbgmResult != none)
      return cbgmResult;
  }
  
  return super.getDefaultPlayerClass(c);
}

function bool checkEndGame(PlayerReplicationInfo winner, string reason) {
  if (reason != "triggered")
    return super.checkEndGame(winner, reason);
  
  gameReplicationInfo.winner = winner.team;
  
  endTime = worldInfo.timeSeconds + endTimeDelay;
  setEndGameFocus(winner);
  return true;
}

defaultproperties
{
//  bForceAllRed=true
//  bPlayersBalanceTeams=false
  defaultInventory.empty
  defaultInventory(0)=class'UTWeap_TauPulseCarbine'
}
