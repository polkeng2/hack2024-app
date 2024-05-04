import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_testing/level.dart';
import 'dart:ui';
import 'dart:async';

class PlazaGame extends FlameGame {
  @override
  Color backgroundColor() => Color.fromARGB(255, 5, 234, 81);

  late final CameraComponent cam;

  final world2 = Level();

  @override
  Future<void> onLoad() async {
    // Add your components here

    cam = CameraComponent.withFixedResolution(
        world: world2, width: 960, height: 960);

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world2]);
    return super.onLoad();
  }
}
