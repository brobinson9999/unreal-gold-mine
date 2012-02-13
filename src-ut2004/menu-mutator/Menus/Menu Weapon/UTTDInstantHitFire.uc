class UTTDInstantHitFire extends SniperFire;

var float LastFireTime;

event ModeDoFire()
{
  LastFireTime = Level.TimeSeconds;
  
  Super.ModeDoFire();
}

function DoTrace(Vector Start, Rotator Dir)
{
//  local int i;
  local Vector X, Y, Z, End, HitLocation, HitNormal;
  local Actor Other;
  local vector EffectOffset, arcEnd;

  MaxRange();

  X = Vector(Dir);
  End = Start + TraceRange * X;

  Other = Weapon.Trace(HitLocation, HitNormal, End, Start, true);

  if ( Other != None && Other != Instigator )
  {
    if (!Other.bWorldGeometry) {
      AttackHitOther(Other, Instigator, HitLocation, X * Momentum, DamageType);

      HitNormal = Vect(0,0,0);
    } else {
      AttackHitWorld(Instigator, HitLocation, X * Momentum, DamageType);
    }
    
    // Update hit.
    if ( WeaponAttachment(Weapon.ThirdPersonActor) != None )
      WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other, HitLocation, HitNormal);
  }
  else
  {
      HitLocation = End;
      HitNormal = Vect(0,0,0);
      WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other,HitLocation,HitNormal);
  }

  // Spawn Effect.
  if ( class'PlayerController'.Default.bSmallWeapons )
    EffectOffset = Weapon.SmallEffectOffset;
  else
    EffectOffset = Weapon.EffectOffset;

  Weapon.GetViewAxes(X, Y, Z);
  if ( Weapon.WeaponCentered()) {
    arcEnd = (Instigator.Location + EffectOffset.Z * Z);
  } else if ( Weapon.Hand == 0 ) {
    if ( class'PlayerController'.Default.bSmallWeapons )
      arcEnd = (Instigator.Location + EffectOffset.X * X);
    else
      arcEnd = (Instigator.Location + EffectOffset.X * X - 0.5 * EffectOffset.Z * Z);
  } else {
    arcEnd = (Instigator.Location + Instigator.CalcDrawOffset(Weapon) + EffectOffset.X * X + Weapon.Hand * EffectOffset.Y * Y + EffectOffset.Z * Z);
  }

  SpawnBeamEffect(arcEnd, Dir, HitLocation, HitNormal, 0);
}

simulated function AttackHitOther(Actor Other, Pawn Instigator, vector HitLocation, vector HitMomentum, class<DamageType> damageType);
simulated function AttackHitWorld(Pawn Instigator, vector HitLocation, vector HitMomentum, class<DamageType> damageType);
simulated function SpawnBeamEffect(Vector Start, Rotator Dir, Vector HitLocation, Vector HitNormal, int ReflectNum);

defaultproperties
{
}
