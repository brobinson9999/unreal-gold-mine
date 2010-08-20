class NonRespawnPawnFactory extends PawnFactory placeable;

var() bool bTriggerEnabled;
var() string toggleEnabled;

simulated function triggered(string triggerName, object relevantObject) {
  if (triggerName == toggleEnabled)
    bTriggerEnabled = !bTriggerEnabled;
    
  if (bTriggerEnabled)
    super.triggered(triggerName, relevantObject);
}

defaultproperties
{
  bTriggerEnabled=true
  pawnClass=class'NonRespawnPawn'
  teamNum=1
}
