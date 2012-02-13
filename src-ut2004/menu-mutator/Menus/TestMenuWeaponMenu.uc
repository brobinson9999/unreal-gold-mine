class TestMenuWeaponMenu extends MenuTest;

simulated function int addState(string stateName) {
  local int newIndex;
  local MenuState newState;
  
  newState.stateName = stateName;

  newIndex = states.length;
  states[newIndex] = newState;
  return newIndex;
}

simulated function addArc(int stateFrom, int stateTo) {
  states[stateFrom].outgoingIndices[states[stateFrom].outgoingIndices.length] = stateTo;
}

simulated function postBeginPlay() {
  local int initial, a, b, aa, ab, ba, bb;
  
  super.postBeginPlay();
  
  initial = addState("initial state");
  a = addState("a");
  b = addState("b");
  aa = addState("aa");
  ab = addState("ab");
  ba = addState("ba");
  bb = addState("bb");
  
  addArc(initial, a);
  addArc(initial, b);
  addArc(a, aa);
  addArc(a, ab);
  addArc(b, ba);
  addArc(b, bb);
}

defaultproperties
{
}