class Triggerable extends Actor placeable;

simulated function triggered(string newEventName, object relevantObject);

defaultproperties
{
  bStatic=false
  bNoDelete=false

  Begin Object Class=SpriteComponent Name=Sprite
    Sprite=Texture2D'EngineResources.S_Trigger'
    HiddenGame=False
    AlwaysLoadOnClient=False
    AlwaysLoadOnServer=False
  End Object
  Components.Add(Sprite)
}
