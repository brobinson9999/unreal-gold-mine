class MenuInputObserver extends InputObserver;

var MenuTest storedMenu;

simulated function setMenu(MenuTest newMenu) {
  storedMenu = newMenu;
  if (storedMenu != none)
    listMenuItems(storedMenu);
}

simulated function listMenuItems(MenuTest menu) {
  local int i;
  local MenuTest.MenuState currentState;
  local vector nextItemLocation;
  
  currentState = menu.getCurrentState();
  for (i=0;i<currentState.outgoingIndices.length;i++) {
    log(i$") "$menu.states[currentState.outgoingIndices].stateName);
  }
}

simulated function bool keyEvent(string key, string action, float delta) {
  if (key == "IK_0") selectMenuItem(storedMenu, 0);
  if (key == "IK_1") selectMenuItem(storedMenu, 1);
  if (key == "IK_2") selectMenuItem(storedMenu, 2);
  if (key == "IK_3") selectMenuItem(storedMenu, 3);
  if (key == "IK_4") selectMenuItem(storedMenu, 4);
  if (key == "IK_5") selectMenuItem(storedMenu, 5);
  if (key == "IK_6") selectMenuItem(storedMenu, 6);
  if (key == "IK_7") selectMenuItem(storedMenu, 7);
  if (key == "IK_8") selectMenuItem(storedMenu, 8);
  if (key == "IK_9") selectMenuItem(storedMenu, 9);
  
  return false;
}

simulated function selectMenuItem(MenuTest menu, int selection) {
  local MenuTest.MenuState currentState;
  
  currentState = menu.getCurrentState();
  menu.setCurrentStateIndex(currentState.outgoingIndices[selection]);
  listMenuItems(menu);
}

defaultproperties
{
}