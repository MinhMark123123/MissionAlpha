
enum PlayerState {
  flashIdle,
  flashMeleeAttack,
  flashMove,
  handgunIdle,
  handgunMeleeAttack,
  handgunMove,
  handgunReload,
  handgunShoot,
  rifleIdle,
  rifleMeleeAttack,
  rifleMove,
  rifleReload,
  rifleShoot,
  knifeIdle,
  knifeMeleeAttack,
  knifeMove;

  bool get isRifle =>
      this == PlayerState.rifleIdle ||
          this == PlayerState.rifleReload ||
          this == PlayerState.rifleShoot ||
          this == PlayerState.rifleMove ||
          this == PlayerState.rifleMeleeAttack;

  bool get isHandGun =>
      this == PlayerState.handgunIdle ||
          this == PlayerState.handgunReload ||
          this == PlayerState.handgunShoot ||
          this == PlayerState.handgunMove ||
          this == PlayerState.handgunMeleeAttack;

  bool get isKnife =>
      this == PlayerState.knifeIdle ||
          this == PlayerState.knifeMove ||
          this == PlayerState.knifeMeleeAttack;

  bool get isFlash => !isRifle && !isHandGun && !isKnife;

  bool get isMoveState =>
      this == PlayerState.rifleMove ||
          this == PlayerState.knifeMove ||
          this == PlayerState.flashMove ||
          this == PlayerState.handgunMove;

  bool get isAttack =>
      this == PlayerState.rifleMeleeAttack ||
          this == PlayerState.rifleShoot ||
          this == PlayerState.rifleReload ||
          this == PlayerState.handgunMeleeAttack ||
          this == PlayerState.handgunShoot ||
          this == PlayerState.handgunReload ||
          this == PlayerState.knifeMeleeAttack ||
          this == PlayerState.flashMeleeAttack;
}
