class TestMenuWeaponPickup extends UTWeaponPickup;

defaultproperties
{
  PickupSound=Sound'PickupSounds.AssaultRiflePickup'
  PickupForce="AssaultRiflePickup"  // jdf

  MaxDesireability=+0.4

  inventoryType=class'TestMenuWeapon'
  StaticMesh=staticmesh'NewWeaponPickups.AssaultPickupSM'
  DrawType=DT_StaticMesh
  DrawScale=0.5
  Standup=(Y=0.25,Z=0.0)
}
