import 'package:flame/components.dart';
import 'package:mobile_light/src/components/collision_block.dart';

class SimplePlatformBlockComponent extends CollisionBlock {
  SimplePlatformBlockComponent({
    super.isPlatform = true,
    super.position,
    super.size,
    super.angle,
    super.nativeAngle,
    super.anchor = Anchor.center,
    this.rotation = 0.0,
  });
  final double rotation;
}
