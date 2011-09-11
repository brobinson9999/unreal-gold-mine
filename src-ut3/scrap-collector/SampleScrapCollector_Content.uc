class SampleScrapCollector_Content extends SampleScrapCollector;


simulated function PostBeginPlay()
{
  Super.PostBeginPlay();

  Mesh.PlayAnim('StartIdle',, true);
}

simulated function StartWorking()
{
  Super.StartWorking();

  Mesh.PlayAnim('Open');
}

simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
  if (bIsWorking && SeqNode.AnimSeqName == 'Open')
  {
    Mesh.PlayAnim('Work',, true);
  }
}

simulated function SetCarryingOre(bool bNewValue)
{
  Super.SetCarryingOre(bNewValue);
  Mesh.PlayAnim(bNewValue ? 'EndIdle' : 'StartIdle',, true);
}

defaultproperties
{
  Physics=PHYS_Walking
  GroundSpeed=200.0
  ControllerClass=class'goldmine.SampleScrapCollectorController'
  ExplosionTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketExplosion'
  ExplosionSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Impact_Cue'
  OreQuantity=50
  JumpZ=100.0
  bCanJump=false
  MaxStepHeight=26.0

  Components.Remove(Sprite)

  Begin Object Name=CollisionCylinder
    CollisionRadius=+0021.000000
    CollisionHeight=+0035.000000
  End Object

  Begin Object class=AnimNodeSequence Name=MeshSequenceA
    bCauseActorAnimEnd=true
  End Object

  Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
  End Object
  Components.Add(MyLightEnvironment)

  Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0
    SkeletalMesh=SkeletalMesh'CH_MiningBot.Mesh.SK_CH_MiningBot'
    AnimSets[0]=AnimSet'CH_MiningBot.Anims.K_HC_MiningBot'
    Animations=MeshSequenceA
    LightEnvironment=MyLightEnvironment
    CollideActors=false
    BlockActors=false
    CastShadow=true
    BlockRigidBody=false
    HiddenGame=false
    Translation=(X=0.0,Y=0.0,Z=0.0)
    Scale3D=(X=1.0,Y=1.0,Z=1.0)
    bUseAsOccluder=false
  End Object
  Components.Add(SkeletalMeshComponent0)
  Mesh=SkeletalMeshComponent0

  Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1
    StaticMesh=StaticMesh'GP_Conquest.SM.Mesh.S_GP_Con_Crystal01'
    LightEnvironment=MyLightEnvironment
    CollideActors=true
    BlockActors=true
    CastShadow=true
    HiddenGame=false
    Translation=(X=25.0,Y=0.0,Z=0.0)
    Scale3D=(X=0.1,Y=0.1,Z=0.1)
    bUseAsOccluder=false
  End Object
  CarriedOre=StaticMeshComponent1
  Components.Add(StaticMeshComponent1)
}
