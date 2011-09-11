class NonRespawnPawn extends UTPawn;

simulated function bool died(Controller killer, class<DamageType> damageType, vector hitLocation) {
  UTTeamGame(worldInfo.game).teams[0].removeFromTeam(controller);
  UTTeamGame(worldInfo.game).teams[1].removeFromTeam(controller);
  
  // if not gone...
  if (controller.playerReplicationInfo != none) {
    // clear lives
    controller.playerReplicationInfo.bOutOfLives = true;
    controller.playerReplicationInfo.numLives = 1;
  }

  if (!super.died(killer, damageType, hitLocation))
    return false;

  return true;
}

defaultproperties
{
}
