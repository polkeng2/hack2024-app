
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class Actor extends SpriteComponent {
  Vector2 ?deltaPosition;
  final String id;

  Actor({ required Vector2 position, required Vector2 size, required this.id }) 
    : super( position: position, size: size );
}