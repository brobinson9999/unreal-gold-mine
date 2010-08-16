class ClassBasedGameMutator extends Mutator;

var private AssociationListActor al;

simulated function AssociationListActor getAssociationList() {
  if (al == none)
    al = spawn(class'AssociationListActor');
    
  return al;
}

simulated function mutate(string mutateString, PlayerController sender) {
  local array<string> msParts;
  local class<ClassBasedGamePawnFactory> newClass;
  local ClassBasedGamePawnFactory newFactory;
  
  msParts = class'PlatformStatics'.static.platformSplitString(mutateString, " ");
  
  if (msParts.length > 0 && msParts[0] ~= "setPlayerClass") {
    if (msParts.length == 2) {
      newClass = class<ClassBasedGamePawnFactory>(dynamicLoadObject(msParts[1], class'Class'));
      if (newClass != none)
        newFactory = new newClass;
      setPlayerClass(sender, newFactory);
    } else
      class'PlatformStatics'.static.platformLog("Usage: setPlayerClass <class-name>");
  }

  super.mutate(mutateString, sender);
}

simulated function setPlayerClass(Controller pc, ClassBasedGamePawnFactory newPlayerClass) {
  local AssociationListActor lal;
  local class<Pawn> newPawnClass;
  
  lal = getAssociationList();
  lal.removeKey(pc);
  
  if (newPlayerClass == none)
    return;
    
  lal.addValue(pc, newPlayerClass);
  
  newPawnClass = getPawnClassForPlayer(pc);
  if (newPawnClass != none)
    pc.setPawnClass(string(newPawnClass), pc.playerReplicationInfo.characterName);
}

simulated function class<Pawn> getPawnClassForPlayer(Controller other) {
  local AssociationListActor lal;
  local ClassBasedGamePawnFactory factory;
  
  lal = getAssociationList();
  factory = ClassBasedGamePawnFactory(lal.getValue(other));
  if (factory != none)
    return factory.getPawnClass();
  else
    return none;
}

function modifyPlayer(Pawn other) {
  local AssociationListActor lal;
  local ClassBasedGamePawnFactory factory;
  
  lal = getAssociationList();
  factory = ClassBasedGamePawnFactory(lal.getValue(other.controller));
  if (factory != none)
    factory.setPawnProperties(other);
  
  super.modifyPlayer(other);
}

defaultproperties
{
  friendlyName="Class-based Game Mutator"
  description="Enables support for class-based games."
}