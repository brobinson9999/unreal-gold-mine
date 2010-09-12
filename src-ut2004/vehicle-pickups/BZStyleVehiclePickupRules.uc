class BZStyleVehiclePickupRules extends GameRules;

function bool OverridePickupQuery(Pawn Other, Pickup item, out byte bAllowPickup)
{
  // Vehicles can only pick up BZStyleVehiclePickups, and BZStyleVehiclePickups can only be picked up by Vehicles.
  if ((Vehicle(other) != none) != (BZStyleVehiclePickup(item) != none))
    return true;

  bAllowPickup = 0;
  return false;
}

defaultProperties
{
}
