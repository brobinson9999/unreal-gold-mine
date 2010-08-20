class TouchTrigger extends TriggerBase;

event touch(Actor other, PrimitiveComponent otherComp, vector hitLocation, vector hitNormal)
{
  if (triggerCount != 0 && Pawn(other) != none && UTPlayerController(Pawn(other).controller) != none)
    triggered(eventName, other);
  
  super.touch(other, otherComp, hitLocation, hitNormal);
}

defaultproperties
{
}
