class MenuCanvasObserver extends CanvasObserver;

var MenuTest storedMenu;

simulated function setMenu(MenuTest newMenu) {
  storedMenu = newMenu;
}

simulated function postRender(Canvas canvas) {
  local int i;
  local MenuTest.MenuState currentState;
  
  if (storedMenu == none)
    return;
    
  currentState = storedMenu.getCurrentState();
  for (i=0;i<currentState.outgoingIndices.length;i++) {
    canvas.drawScreenText(i$") "$storedMenu.states[currentState.outgoingIndices[i]].stateName, 0, 0 + 100*i, DP_UpperLeft);
    log("displaying on "$canvas);
  }
}

simulated function cleanup() {
  local CanvasDriver driver;

  storedMenu = none;

  foreach allObjects(class'CanvasDriver', driver)
    driver.removeObserver(self);
    
  super.cleanup();
}

defaultproperties
{
}