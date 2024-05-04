import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
// import 'package:flutter_testing/level.dart';
import 'dart:ui';
import 'dart:async';

class PlazaGame extends FlameGame
    with
        ScrollDetector,
        ScaleDetector,
        TapDetector,
        MultiTouchDragDetector {
  @override
  Color backgroundColor() => const Color.fromARGB(255, 5, 234, 81);

  late TiledComponent mapC;
  late final CameraComponent cam;
  static const zoomPerScrollUnit = 0.02;
  static const double _minZoom = 1.0;
  static const double _maxZoom = 2.0;
  double _startZoom = _maxZoom;

  @override
  Future<void> onLoad() async {
    camera.viewfinder
      ..zoom = _startZoom
      ..anchor = Anchor.center;

    camera.moveBy(Vector2(32*16, 32*16));

    mapC = await TiledComponent.load(
      'Plaza-01.tmx',
      Vector2(32, 32),
    );
    world.add(mapC);
  }

  void clampZoom() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }


  @override
  void onScroll(PointerScrollInfo info) {
    camera.viewfinder.zoom += info.scrollDelta.global.y.sign * zoomPerScrollUnit;
    _checkScaleBorders();
    _checkDragBorders();
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;
    if (!currentScale.isIdentity()) {
      camera.viewfinder.zoom = _startZoom * currentScale.y;
      _checkScaleBorders();
      _checkDragBorders();
    } else {
      final delta = info.delta.global;
      camera.viewfinder.position.translate(-delta.x, -delta.y);
    }
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info)  {
    _processDrag(info);
  }

  void _processDrag(DragUpdateInfo info) {
    final delta = info.delta.global;
    final zoomDragFactor = 1.0 / _startZoom;
    final currentPosition = camera.viewfinder.position;

    camera.viewfinder.position = currentPosition.translated(
      -delta.x * zoomDragFactor,
      -delta.y * zoomDragFactor,
    );
    _checkDragBorders();
  }

  void _checkScaleBorders() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void _checkDragBorders() {
    final worldRect = camera.visibleWorldRect;
    final currentPosition = camera.viewfinder.position;
    final mapSize = Offset(mapC.width, mapC.height);

    var xTranslate = 0.0;
    var yTranslate = 0.0;

    if (worldRect.topLeft.dx < 0.0) {
      xTranslate = -worldRect.topLeft.dx;
    } else if (worldRect.bottomRight.dx > mapSize.dx) {
      xTranslate = mapSize.dx - worldRect.bottomRight.dx;
    }

    if (worldRect.topLeft.dy < 0.0) {
      yTranslate = -worldRect.topLeft.dy;
    } else if (worldRect.bottomRight.dy > mapSize.dy) {
      yTranslate = mapSize.dy - worldRect.bottomRight.dy;
    }

    camera.viewfinder.position = currentPosition.translated(xTranslate, yTranslate);
  }
/*
  */
}
