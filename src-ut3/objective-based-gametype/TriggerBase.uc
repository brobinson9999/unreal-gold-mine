class TriggerBase extends Trigger abstract;

var int triggerCount;

var() string eventName;

simulated function triggered(string newEventName, object relevantObject) {
  triggerCount--;

  broadcastTrigger(worldInfo, newEventName, relevantObject);
}

simulated static function broadcastTrigger(WorldInfo winfo, string newEventName, object relevantObject) {
  local Triggerable triggerable;
  local int i;
  local Sequence gameSeq;
  local array<SequenceObject> allSeqEvents;

  // if no relevant object, then the world is the most relevant object.
  if (relevantObject == none)
    relevantObject = winfo;

//  `log("broadcasting "$newEventName$" "$relevantObject);
  if (newEventName == "")
    return;
    
  foreach winfo.dynamicActors(class'Triggerable', triggerable) {
    triggerable.triggered(newEventName, relevantObject);
  }

  gameSeq = winfo.getGameSequence();
  if(gameSeq != none) {
    gameSeq.findSeqObjectsByClass(class'SeqEvent_Trigger', true, allSeqEvents);
    for(i=0;i<allSeqEvents.length;i++)
      if (SeqEvent_Trigger(allSeqEvents[i]).triggerEvent ~= newEventName) {
        SeqEvent_Trigger(allSeqEvents[i]).relevantObject = relevantObject;
//        `log("activating "$allSeqEvents[i]$" "$newEventName$" "$winfo);
        SeqEvent_Trigger(allSeqEvents[i]).checkActivate(Actor(relevantObject), Actor(relevantObject));
//          `log("failed to activate "$allSeqEvents[i]$"!");
      }
  }
}

simulated static function bool willKismetFailOn() {
}

defaultproperties
{
  triggerCount=-1
}
