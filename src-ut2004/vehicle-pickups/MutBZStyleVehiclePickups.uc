class MutBZStyleVehiclePickups extends Mutator;

function PostBeginPlay()
{
  local BZStyleVehiclePickupRules G;

  Super.PostBeginPlay();
  G = spawn(class'BZStyleVehiclePickupRules');

  if ( Level.Game.GameRulesModifiers == None )
    Level.Game.GameRulesModifiers = G;
  else
    Level.Game.GameRulesModifiers.AddGameRules(G);
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
  local Vehicle V;

  V = Vehicle(Other);

  if (V != None)
    V.bCanPickupInventory = True;

  return true;
}

DefaultProperties
{
    GroupName="VehiclePickups"
    FriendlyName="BZ-Style Vehicle Pickups"
    Description="Vehicles will pick up items normally."
}
