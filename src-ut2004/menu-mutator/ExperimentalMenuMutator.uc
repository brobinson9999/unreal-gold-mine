class ExperimentalMenuMutator extends Mutator;

simulated function mutate(string mutateString, PlayerController sender) {
  local array<string> msParts;
  local class<MenuTest> newClass;
  local MenuTest newMenu;

  local MenuInputObserver mio;
  local InputDriver inputDriver;

  local MenuCanvasObserver mco;
  local CanvasDriver canvasDriver;
  
  msParts = class'PlatformStatics'.static.platformSplitString(mutateString, " ");
  
  if (msParts.length > 0 && msParts[0] ~= "menu") {
    if (msParts.length == 2) {
      newClass = class<MenuTest>(dynamicLoadObject(msParts[1], class'Class'));
      if (newClass != none) {
        newMenu = spawn(newClass);
        newMenu.setCurrentStateIndex(0);
        
        inputDriver = class'InputDriver'.static.installNewInputDriver(sender);
        mio = new class'MenuInputObserver';
        inputDriver.addObserver(mio);
        mio.setMenu(newMenu);
        
        canvasDriver = class'CanvasDriver'.static.installNewCanvasDriver(sender);
        mco = new class'MenuCanvasObserver';
        canvasDriver.addObserver(mco);
        mco.setMenu(newMenu);
      }
    } else
      class'PlatformStatics'.static.platformLog("Usage: menu <menu-class-name>");
  }

  super.mutate(mutateString, sender);
}

defaultproperties
{
  friendlyName="Experimental Menu Mutator"
  description="Experiment involving transient interactions to provide script-driven menus."
}