class BZStyleVehicleWeaponPickup extends BZStyleVehiclePickup;

var class<ONSWeapon> weaponClass;

auto state Pickup
{
  function Touch( actor Other )
  {
    local ONSVehicle vehicle;

    if ( ValidTouch(Other) ) {
      vehicle = ONSVehicle(Other);
      if (vehicle != none) {
        vehicle.driverweapons[0].weaponClass = weaponClass;
        if (vehicle.weapons[0] != none)
          vehicle.weapons[0].destroy();
        vehicle.weapons[0] = vehicle.spawn(weaponClass, vehicle,, vehicle.location, rot(0,0,0));
        vehicle.attachToBone(vehicle.weapons[0], vehicle.driverWeapons[0].weaponBone);
        if (!vehicle.weapons[0].bAimable)
          vehicle.weapons[0].currentAim = rot(0,32768,0);

        if (vehicle.activeWeapon < vehicle.weapons.length) {
          vehicle.pitchUpLimit = vehicle.weapons[vehicle.activeWeapon].pitchUpLimit;
          vehicle.pitchDownLimit = vehicle.weapons[vehicle.activeWeapon].pitchDownLimit;
        }
      }
    }
  }
}

defaultproperties
{
  weaponClass=class'ONSTankSecondaryTurret'
  
  PickupMessage="You picked up a vehicle weapon."

  RespawnTime=30.000000
  MaxDesireability=0.700000
  RemoteRole=ROLE_DumbProxy
  AmbientGlow=128
  Mass=10.000000

  Physics=PHYS_Rotating
  RotationRate=(Yaw=24000)
  DrawScale=0.3
  PickupSound=sound'PickupSounds.HealthPack'
  PickupForce="HealthPack"  // jdf
  DrawType=DT_StaticMesh
  StaticMesh=StaticMesh'E_Pickups.MidHealth'    

  CollisionHeight=23.000000
  CollisionRadius=32.0
  Style=STY_AlphaZ
  ScaleGlow=0.6
  TransientSoundVolume=0.35
  CullDistance=+6500.0
}
