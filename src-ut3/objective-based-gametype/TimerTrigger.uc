class TimerTrigger extends TriggerBase;

var() float retriggerDuration;
var float retriggerTimer;

simulated function postBeginPlay() {
  retriggerTimer = retriggerDuration;

  super.postBeginPlay();
}

simulated function tick(float delta) {
  retriggerTimer -= delta;
  while (retriggerTimer < 0) {
    triggered(eventName, none);
    retriggerTimer += retriggerDuration;
  }
  
  super.tick(delta);
}

defaultproperties
{
  triggerCount=-1
  retriggerDuration=10
}
