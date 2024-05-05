import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/components/actor.dart';
import 'package:flame_tiled/flame_tiled.dart';

typedef StringCall = void Function(String);

class MeetsGame extends FlameGame
    with ScrollDetector, ScaleDetector, TapDetector, MultiTouchDragDetector {
  final StringCall callback;

  List actors = [];
  List users = [];
  String mapTiled;
  MeetsGame(
      {required this.mapTiled,
      required this.users,
      required this.callback});

  late TiledComponent mapC;
  late final CameraComponent cam;
  static const zoomPerScrollUnit = 0.02;
  static const double _minZoom = 1.0;
  static const double _maxZoom = 1.0;
  double _startZoom = _maxZoom;

  final regular = TextPaint(
      style: const TextStyle(
    fontSize: 9,
    color: Colors.white,
  ));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // CAMERA
    camera.viewfinder
      ..zoom = _startZoom
      ..anchor = Anchor.center;

    camera.moveBy(Vector2(32 * 14, 32 * 16));

    mapC = await TiledComponent.load(
      mapTiled,
      Vector2(32, 32),
    );
    world.add(mapC);
    int countY = 0, multX = 0, multY = 1;
    for (int i = 0; i < users.length; ++i) {
      double posX = 32 * 8 + multX * 100;
      double posY = 32 * 8 + multY.toDouble() * 100;
      ++countY;
      ++multX;
      if (countY == 5) {
        ++multY;
        multX = 0;
        countY = 0;
      }
      Actor actor = Actor(
          position: Vector2(posX, posY),
          size: Vector2(37, 72),
          id: users[i].name);
      actor.sprite = await loadSprite(users[i].avatarSprite.replaceFirst(RegExp('assets/images/'), ''));
      actors.add(actor);
      world.add(actor);
      
      world.add(TextComponent(
          text: users[i].name,
          position: Vector2(posX, posY + 75),
          textRenderer: regular));
          
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    final clickOnMapPoint = camera.globalToLocal(info.eventPosition.global);

    // Loop through all actors to check if the tap occurred on any of them
    for (Actor actor in actors) {
      if (actor.toRect().contains(clickOnMapPoint.toOffset())) {
        callback(actor.id);
      }
    }
  }

  // CAMERA MOVIMENT
  void clampZoom() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  @override
  void onScroll(PointerScrollInfo info) {
    camera.viewfinder.zoom +=
        info.scrollDelta.global.y.sign * zoomPerScrollUnit;
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
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
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

    camera.viewfinder.position =
        currentPosition.translated(xTranslate, yTranslate);
  }
}
