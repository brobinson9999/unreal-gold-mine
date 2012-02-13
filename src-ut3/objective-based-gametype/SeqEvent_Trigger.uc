class SeqEvent_Trigger extends SequenceEvent;

// This event facilitates interaction with trigger systems.
// This event fires when it detects a trigger event matching it's triggerEvent variable.

var() string triggerEvent;
var() object relevantObject;

event activated() {
//  `log(self$" activated! "$triggerEvent$" "$relevantObject);
}

defaultproperties
{
  ObjName="Recieve Trigger Event"
  ObjCategory="Triggers"
  ObjClassVersion=2

  VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Trigger Event Name",PropertyName=triggerEvent,bWriteable=false)
  VariableLinks(2)=(ExpectedType=class'SeqVar_Object',LinkDesc="RelevantObject",PropertyName=relevantObject,bWriteable=true)
  
  bPlayerOnly=false
}
