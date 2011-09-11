class TestMenuWeapon extends SniperRifle;

var MenuTest menu;

simulated function postBeginPlay() {
  super.postBeginPlay();
  
  menu = spawn(class'TestMenuWeaponMenu');
  TestMenuWeaponClick(fireMode[0]).menu = menu;
}

simulated function destroyed() {
  if (TestMenuWeaponClick(fireMode[0]) != none)
    TestMenuWeaponClick(fireMode[0]).menu = none;
  
  if (menu != none)
    menu.destroy();
    
  super.destroyed();
}

defaultproperties
{
  fireModeClass(0)=TestMenuWeaponClick
//  fireModeClass(1)=UTTDMenuWeaponClick

  ItemName="Experimental Menu Weapon"
  PickupClass=class'TestMenuWeaponPickup'
}
