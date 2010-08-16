class ClassBasedGamePawnFactory extends BaseObject;

simulated function Pawn createPawn(GameInfo ginfo, vector startLocation, rotator startRotation);
simulated function class<Pawn> getPawnClass();
simulated function setPawnProperties(Pawn other);

defaultproperties
{
}