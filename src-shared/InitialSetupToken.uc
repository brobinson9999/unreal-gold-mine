class InitialSetupToken extends Inventory;

// A token given to a Pawn by a DefaultClassBasedGamePawnFactory, so it knows whether or not it has performed initial setup.
// It does this so that it doesn't give inventory more than once in case modifyPlayer is called more than once.

defaultproperties
{
}