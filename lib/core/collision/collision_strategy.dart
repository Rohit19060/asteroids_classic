import 'dart:math';

import '../../features/tracker/domain/entities/particle.dart';
import '../../features/tracker/domain/entities/player.dart';
import 'circle_collision_strategy.dart';

class CircleCollisionStrategy implements CollisionStrategy {
  @override
  bool checkCollision(Particle particle, Player player) {
    final dx = particle.position.dx - player.position.dx;
    final dy = particle.position.dy - player.position.dy;
    final distance = sqrt(dx * dx + dy * dy);
    final combinedRadius = particle.radius + player.radius;
    return distance < combinedRadius;
  }
}
