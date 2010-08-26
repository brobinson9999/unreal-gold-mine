class TestMenuWeaponClick extends UTTDInstantHitFire;

var class<Actor> spawnClass;
var MenuTest menu;

simulated function SpawnBeamEffect(Vector Start, Rotator Dir, Vector HitLocation, Vector HitNormal, int ReflectNum)
{
  local HB_BeamEffect Beam;

  Beam = spawn(class'HB_BeamEffect',,, Start, Dir);
  Beam.SetDrawScale(0.5);
  Beam.HitLocation = HitLocation;

  if (Level.NetMode != NM_DedicatedServer)
    Beam.SetupBeam();
}

simulated function attackHitOther(Actor other, Pawn instigator, vector hitLocation, vector hitMomentum, class<DamageType> damageType) {
  menuClick(other, instigator, hitLocation);
}

simulated function AttackHitWorld(Pawn Instigator, vector HitLocation, vector HitMomentum, class<DamageType> damageType) {
  menuClick(none, instigator, hitLocation);
}

simulated function array<IconMenuItem> getMenuItems(Pawn instigator) {
  local IconMenuItem imi;
  local array<IconMenuItem> result;
  
  foreach instigator.dynamicActors(class'IconMenuItem', imi)
    result[result.length] = imi;
    
  return result;
}

function doTrace(vector start, rotator dir) {
  local int i;
  local array<IconMenuItem> menuItems;
  
  menuItems = getMenuItems(Pawn(weapon.owner));
  for (i=0;i<menuItems.length;i++)
    menuItems[i].prepareForClick();
    
  super.doTrace(start, dir);
}

simulated function menuClick(Actor other, Pawn instigator, vector hitLocation) {
  local int i;
  local array<IconMenuItem> oldMenuItems;
  
  oldMenuItems = getMenuItems(instigator);
  
  instigator.consoleCommand("adminsay Hit "$other);

  if (other == none) {
    spawnMenuItemsForActor(other, instigator, hitLocation);
  } else if (IconMenuItem(other) != none) {
    menu.setCurrentStateIndex(IconMenuItem(other).associatedState);
    spawnMenuItems(hitLocation);
  } else {
    spawnMenuItemsForActor(other, instigator, hitLocation);
  }
  
  for (i=0;i<oldMenuItems.length;i++)
    oldMenuItems[i].destroy();
}

simulated function spawnMenuItemsForActor(Actor other, Pawn instigator, vector hitLocation) {
  menu.setCurrentStateIndex(0);
  spawnMenuItems(hitLocation);
}

simulated function spawnMenuItems(vector spawnLocation) {
  local int i;
  local MenuTest.MenuState currentState;
  local vector nextItemLocation;
  
  nextItemLocation = spawnLocation;
  
  currentState = menu.getCurrentState();
  for (i=0;i<currentState.outgoingIndices.length;i++) {
    newMenuItem(nextItemLocation, spawnLocation, currentState.outgoingIndices[i], none);
    nextItemLocation = nextItemLocation + vect(100,0,0);
  }
}

simulated function IconMenuItem newMenuItem(vector newItemLocation, vector newItemSpawnLocation, int newItemState, optional class<actor> newItemSpawnClass) {
  local IconMenuItem result;
  
  result = spawn(class'IconMenuItem',,, newItemLocation);
  result.spawnLocation = newItemSpawnLocation;
  result.associatedState = newItemState;
  result.spawnClass = newItemSpawnClass;
  
  return result;
}

defaultproperties
{
  AmmoPerFire=0

  FireRate=0.75
  BotRefireRate=0.01
}
