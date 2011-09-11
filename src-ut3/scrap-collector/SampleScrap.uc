class SampleScrap extends Actor;

var float scrapQuantity;

defaultproperties
{
  Begin Object Class=SpriteComponent Name=Sprite
    Sprite=Texture2D'EngineResources.S_Inventory'
  End Object
  Components.Add(Sprite)

  Begin Object Class=CylinderComponent NAME=CollisionCylinder
    CollisionRadius=+00030.000000
    CollisionHeight=+00020.000000
    CollideActors=true
  End Object
  CollisionComponent=CollisionCylinder
  Components.Add(CollisionCylinder)

  bHidden=false
  bCollideActors=true
  bCollideWorld=true

  bOrientOnSlope=true
  bShouldBaseAtStartup=true

  bIgnoreEncroachers=false
  bIgnoreRigidBodyPawns=false
  bUpdateSimulatedPosition=false
}
