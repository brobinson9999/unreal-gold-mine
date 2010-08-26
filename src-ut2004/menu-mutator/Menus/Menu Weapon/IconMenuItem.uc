class IconMenuItem extends Actor;

//var name actionName;
var int associatedState;
var vector spawnLocation;
var class<actor> spawnClass;

simulated function prepareForClick() {
  setCollision(true,true,true);
//  bCollideActors=true;
  bCollideWorld=true;
//  bBlockActors=true;
//  bBlockPlayers=true;
  bBlockProjectiles=true;
  bProjTarget=true;
  bBlockZeroExtentTraces=true;
  bBlockNonZeroExtentTraces=true;
}

defaultproperties
{
  drawType=DT_Sprite
  bCollideActors=false
  bCollideWorld=false
  bBlockActors=false
  bBlockPlayers=false
  bBlockProjectiles=false
  bProjTarget=false
  bBlockZeroExtentTraces=false
  bBlockNonZeroExtentTraces=false
}
