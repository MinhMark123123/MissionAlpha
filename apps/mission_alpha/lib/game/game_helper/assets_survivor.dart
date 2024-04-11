import 'package:flame/components.dart';

class AssetsSurvivor {
  static const basePath = "top_down_survivor";
  static const basePathFeet = "$basePath/feet";
  static const basePathFlash = "$basePath/flashlight";
  static const basePathHandgun = "$basePath/handgun";
  static const basePathRifle = "$basePath/rifle";
  static const basePathKnife = "$basePath/knife";
  static final feetIdle = ["$basePathFeet/idle/survivor-idle_0.png"];
  static final feetRun = List<String>.generate(
    20,
    (index) => "$basePathFeet/run/survivor-run_$index.png",
  );
  static final feetStrafeLeft = List<String>.generate(
    20,
    (index) => "$basePathFeet/strafe_left/survivor-strafe_left_$index.png",
  );
  static final feetStrafeRight = List<String>.generate(
    20,
    (index) => "$basePathFeet/strafe_right/survivor-strafe_right_$index.png",
  );
  static final feetWalk = List<String>.generate(
    20,
    (index) => "$basePathFeet/walk/survivor-walk_$index.png",
  );

  //---->
  static final flashIdle = List<String>.generate(
    20,
    (index) => "$basePathFlash/idle/survivor-idle_flashlight_$index.png",
  );
  static final flashMeleeAttack = List<String>.generate(
    15,
    (index) =>
        "$basePathFlash/meleeattack/survivor-meleeattack_flashlight_$index.png",
  );
  static final flashMove = List<String>.generate(
    20,
    (index) => "$basePathFlash/move/survivor-move_flashlight_$index.png",
  );

  //---->
  static final handgunIdle = List<String>.generate(
    20,
    (index) => "$basePathHandgun/idle/survivor-idle_handgun_$index.png",
  );
  static final handgunMeleeAttack = List<String>.generate(
    15,
    (index) =>
        "$basePathHandgun/meleeattack/survivor-meleeattack_handgun_$index.png",
  );
  static final handgunMove = List<String>.generate(
    20,
    (index) => "$basePathHandgun/move/survivor-move_handgun_$index.png",
  );
  static final handgunShoot = List<String>.generate(
    3,
    (index) => "$basePathHandgun/shoot/survivor-shoot_handgun_$index.png",
  );
  static final handgunReload = List<String>.generate(
    15,
    (index) => "$basePathHandgun/reload/survivor-reload_handgun_$index.png",
  );

  //---->
  static final rifleIdle = List<String>.generate(
    20,
    (index) => "$basePathRifle/idle/survivor-idle_rifle_$index.png",
  );
  static final rifleMeleeAttack = List<String>.generate(
    15,
    (index) =>
        "$basePathRifle/meleeattack/survivor-meleeattack_rifle_$index.png",
  );
  static final rifleMove = List<String>.generate(
    20,
    (index) => "$basePathRifle/move/survivor-move_rifle_$index.png",
  );
  static final rifleShoot = List<String>.generate(
    3,
    (index) => "$basePathRifle/shoot/survivor-shoot_rifle_$index.png",
  );
  static final rifleReload = List<String>.generate(
    15,
    (index) => "$basePathRifle/reload/survivor-reload_rifle_$index.png",
  );

  //---->
  static final knifeIdle = List<String>.generate(
    20,
    (index) => "$basePathKnife/idle/survivor-idle_knife_$index.png",
  );
  static final knifeMeleeAttack = List<String>.generate(
    15,
    (index) =>
        "$basePathKnife/meleeattack/survivor-meleeattack_knife_$index.png",
  );
  static final knifeMove = List<String>.generate(
    20,
    (index) => "$basePathKnife/move/survivor-move_knife_$index.png",
  );
}

class SpriteAnimProvider {
  static final SpriteAnimProvider _instance = SpriteAnimProvider._();

  SpriteAnimProvider._();

  factory SpriteAnimProvider() {
    return _instance;
  }

  late SpriteAnimation feetIdleAnim;
  late SpriteAnimation feetWalkAnim;
  late SpriteAnimation feetRunAnim;
  late SpriteAnimation feetStrafeLeftAnim;
  late SpriteAnimation feetStrafeRightAnim;
  late SpriteAnimation flashIdleAnim;
  late SpriteAnimation flashMoveAnim;
  late SpriteAnimation flashMeleeAttackAnim;
  late SpriteAnimation handgunIdleAnim;
  late SpriteAnimation handgunMeleeAttackAnim;
  late SpriteAnimation handgunReloadAnim;
  late SpriteAnimation handgunMoveAnim;
  late SpriteAnimation handgunShootAnim;
  late SpriteAnimation rifleIdleAnim;
  late SpriteAnimation rifleMeleeAttackAnim;
  late SpriteAnimation rifleReloadAnim;
  late SpriteAnimation rifleMoveAnim;
  late SpriteAnimation rifleShootAnim;
  late SpriteAnimation knifeIdleAnim;
  late SpriteAnimation knifeMeleeAttackAnim;
  late SpriteAnimation knifeMoveAnim;
  double timeStepIdle = 0.1;
  double timeStepMeleeAttack = 0.1;
  double timeStepMove = 0.1;
  double timeReload = 0.1;
  double timeShoot = 0.1;

  Future<void> initAnim() async {
    await _initFlashAnim();
    await _initHandGunAnim();
    await _initRifleAnim();
    await _initKnifeAnim();
  }

  Future<void> _initFlashAnim() async {
    final flashIdle = await Future.wait(
      AssetsSurvivor.flashIdle
          .map((e) => Sprite.load(e, srcSize: Vector2(303, 223))),
    );
    final flashMeleeAttack = await Future.wait(
      AssetsSurvivor.flashMeleeAttack
          .map((e) => Sprite.load(e, srcSize: Vector2(326, 246))),
    );
    final flashMove = await Future.wait(
      AssetsSurvivor.flashMove
          .map((e) => Sprite.load(e, srcSize: Vector2(305, 231))),
    );
    flashIdleAnim = SpriteAnimation.spriteList(
      flashIdle,
      stepTime: timeStepIdle,
    );
    flashMoveAnim = SpriteAnimation.spriteList(
      flashMove,
      stepTime: timeStepMove,
    );
    flashMeleeAttackAnim = SpriteAnimation.spriteList(
      flashMeleeAttack,
      stepTime: timeStepMeleeAttack,
    );
  }

  Future<void> _initHandGunAnim() async {
    final handgunIdle = await Future.wait(
      AssetsSurvivor.handgunIdle
          .map((e) => Sprite.load(e, srcSize: Vector2(253, 216))),
    );
    final handgunMeleeAttack = await Future.wait(
      AssetsSurvivor.handgunMeleeAttack
          .map((e) => Sprite.load(e, srcSize: Vector2(291, 256))),
    );
    final handgunMove = await Future.wait(
      AssetsSurvivor.handgunMove
          .map((e) => Sprite.load(e, srcSize: Vector2(258, 220))),
    );
    final handgunReload = await Future.wait(
      AssetsSurvivor.handgunReload
          .map((e) => Sprite.load(e, srcSize: Vector2(260, 230))),
    );
    final handgunShoot = await Future.wait(
      AssetsSurvivor.handgunShoot
          .map((e) => Sprite.load(e, srcSize: Vector2(255, 215))),
    );
    handgunIdleAnim = SpriteAnimation.spriteList(
      handgunIdle,
      stepTime: timeStepIdle,
    );
    handgunMeleeAttackAnim = SpriteAnimation.spriteList(
      handgunMeleeAttack,
      stepTime: timeStepMeleeAttack,
    );
    handgunMoveAnim = SpriteAnimation.spriteList(
      handgunMove,
      stepTime: timeStepMove,
    );
    handgunReloadAnim = SpriteAnimation.spriteList(
      handgunReload,
      stepTime: timeReload,
    );
    handgunShootAnim = SpriteAnimation.spriteList(
      handgunShoot,
      stepTime: timeShoot,
    );
  }

  Future<void> _initRifleAnim() async {
    final rifleIdle = await Future.wait(
      AssetsSurvivor.rifleIdle
          .map((e) => Sprite.load(e, srcSize: Vector2(313, 207))),
    );
    final rifleMeleeAttack = await Future.wait(
      AssetsSurvivor.rifleMeleeAttack
          .map((e) => Sprite.load(e, srcSize: Vector2(358, 353))),
    );
    final rifleMove = await Future.wait(
      AssetsSurvivor.rifleMove
          .map((e) => Sprite.load(e, srcSize: Vector2(313, 206))),
    );
    final rifleReload = await Future.wait(
      AssetsSurvivor.rifleReload
          .map((e) => Sprite.load(e, srcSize: Vector2(322, 217))),
    );
    final rifleShoot = await Future.wait(
      AssetsSurvivor.rifleShoot
          .map((e) => Sprite.load(e, srcSize: Vector2(312, 206))),
    );
    rifleIdleAnim = SpriteAnimation.spriteList(
      rifleIdle,
      stepTime: timeStepIdle,
    );
    rifleMeleeAttackAnim = SpriteAnimation.spriteList(
      rifleMeleeAttack,
      stepTime: timeStepMeleeAttack,
    );
    rifleMoveAnim = SpriteAnimation.spriteList(
      rifleMove,
      stepTime: timeStepMove,
    );
    rifleReloadAnim = SpriteAnimation.spriteList(
      rifleReload,
      stepTime: timeReload,
    );
    rifleShootAnim = SpriteAnimation.spriteList(
      rifleShoot,
      stepTime: timeShoot,
    );
  }

  Future<void> _initKnifeAnim() async {
    final knifeIdle = await Future.wait(
      AssetsSurvivor.knifeIdle
          .map((e) => Sprite.load(e, srcSize: Vector2(289, 224))),
    );
    final knifeMeleeAttack = await Future.wait(
      AssetsSurvivor.knifeMeleeAttack
          .map((e) => Sprite.load(e, srcSize: Vector2(329, 300))),
    );
    final knifeMove = await Future.wait(
      AssetsSurvivor.knifeMove
          .map((e) => Sprite.load(e, srcSize: Vector2(279, 219))),
    );
    knifeIdleAnim = SpriteAnimation.spriteList(
      knifeIdle,
      stepTime: timeStepIdle,
    );
    knifeMeleeAttackAnim = SpriteAnimation.spriteList(
      knifeMeleeAttack,
      stepTime: timeStepMeleeAttack,
    );
    knifeMoveAnim = SpriteAnimation.spriteList(
      knifeMove,
      stepTime: timeStepMove,
    );
  }

  Future<void> initFeetAnim() async {
    final feetIdle = await Future.wait(AssetsSurvivor.feetIdle.map(
      (e) => Sprite.load(
        e,
        srcSize: Vector2(132, 155),
      ),
    ));
    final feetRun = await Future.wait(AssetsSurvivor.feetRun.map(
      (e) => Sprite.load(
        e,
        srcSize: Vector2(204, 124),
      ),
    ));
    final feetStrafeLeft = await Future.wait(AssetsSurvivor.feetStrafeLeft.map(
      (e) => Sprite.load(
        e,
        srcSize: Vector2(204, 124),
      ),
    ));
    final feetStrafeRight =
        await Future.wait(AssetsSurvivor.feetStrafeRight.map(
      (e) => Sprite.load(
        e,
        srcSize: Vector2(204, 124),
      ),
    ));
    final feetWalk = await Future.wait(AssetsSurvivor.feetWalk.map(
      (e) => Sprite.load(
        e,
        srcSize: Vector2(172, 124),
      ),
    ));

    feetIdleAnim = SpriteAnimation.spriteList(
      feetIdle,
      stepTime: timeStepIdle,
    );
    feetRunAnim = SpriteAnimation.spriteList(
      feetRun,
      stepTime: timeStepMove,
    );
    feetWalkAnim = SpriteAnimation.spriteList(
      feetWalk,
      stepTime: timeStepMove,
    );
    feetStrafeLeftAnim = SpriteAnimation.spriteList(
      feetStrafeLeft,
      stepTime: timeStepMove,
    );
    feetStrafeRightAnim = SpriteAnimation.spriteList(
      feetStrafeRight,
      stepTime: timeStepMove,
    );
  }
}
