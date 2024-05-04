import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    // Add your components here
    level = await TiledComponent.load(
      'Plaza-01.tmx',
      Vector2(32, 32),
    );

    add(level);

    return super.onLoad();
  }
}
