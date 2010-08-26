class MenuTest extends Actor;

struct MenuState {
  var string stateName;
  var array<int> outgoingIndices;
  var Actor enterAction;
//  var string consoleCommand;
};

var array<MenuState> states;
var int currentStateIndex;

simulated function MenuState getCurrentState() {
  return states[currentStateIndex];
}

simulated function setCurrentStateIndex(int newStateIndex) {
  currentStateIndex = newStateIndex;
  enterState();
}

simulated function enterState() {
  local MenuState currentState;
  
  currentState = getCurrentState();
  log("entered state: "$currentState.stateName);
  if (currentState.enterAction != none)
    currentState.enterAction.trigger(none, none);
}

simulated function traverseArc(int arcIndex) {
  setCurrentStateIndex(getCurrentState().outgoingIndices[arcIndex]);
}

defaultproperties
{
  DrawType=DT_None
  bHidden=true
}