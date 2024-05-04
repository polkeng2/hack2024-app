import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter_testing/level.dart';
import 'dart:ui';
import 'dart:async';

class PlazaGame extends FlameGame
    with
        ScrollDetector,
        ScaleDetector,
        MultiTouchTapDetector,
        MultiTouchDragDetector {
  @override
  Color backgroundColor() => const Color.fromARGB(255, 5, 234, 81);

  late final CameraComponent cam;

  final world2 = Level();

  @override
  Future<void> onLoad() async {
    cam = CameraComponent(
        world: world2, viewport: MaxViewport(), viewfinder: Viewfinder());

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world2]);
    return super.onLoad();
  }

  void clampZoom() {
    cam.viewfinder.zoom = cam.viewfinder.zoom.clamp(0.05, 3.0);
  }

  static const zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    cam.viewfinder.zoom += info.scrollDelta.global.y.sign * zoomPerScrollUnit;
    clampZoom();
  }

  late double startZoom;
  @override
  void onScaleStart(_) {
    startZoom = cam.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;
    if (!currentScale.isIdentity()) {
      cam.viewfinder.zoom = startZoom * currentScale.y;
      clampZoom();
    } else {
      final delta = info.delta.global;
      cam.viewfinder.position.translate(-delta.x, -delta.y);
    }
  }
}
