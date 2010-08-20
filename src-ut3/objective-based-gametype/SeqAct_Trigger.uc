class SeqAct_Trigger extends SequenceAction;

// This event facilitates interaction with trigger systems.
// This event fires the trigger event matching it's triggerEvent variable with the relevant object matching it's relevantObject variable.

var() string triggerEvent;
var() object relevantObject;

event activated() {
  class'TriggerBase'.static.broadcastTrigger(getWorldInfo(), triggerEvent, relevantObject);
}

defaultproperties
{
  ObjName="Send Trigger Event"
  ObjCategory="Triggers"
  ObjClassVersion=2

  // ?
  InputLinks(0)=(LinkDesc="Input")

  VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Trigger Event Name",PropertyName=triggerEvent)
  VariableLinks(2)=(ExpectedType=class'SeqVar_Object',LinkDesc="Relevant Object",PropertyName=relevantObject)
  
//  HandlerName=activated
}
