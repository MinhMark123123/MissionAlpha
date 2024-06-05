import 'package:flame/components.dart';
import 'package:mobile_light/mobile_light.dart';

class PlatformBlockComponent extends SimplePlatformBlockComponent {
  PlatformBlockComponent({
    super.isPlatform = true,
    super.position,
    super.size,
    super.angle,
    super.nativeAngle,
    super.anchor = Anchor.center,
    super.rotation,
  });

  @override
  bool get debugMode => true;
}
