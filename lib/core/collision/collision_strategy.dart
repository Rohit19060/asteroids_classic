import 'dart:math';

import 'package:flutter/material.dart';

import '../../features/tracker/domain/entities/bullet.dart';
import '../../features/tracker/domain/entities/particle.dart';
import 'circle_collision_strategy.dart';

class CircleCollisionStrategy implements CollisionStrategy {
  @override
  bool checkCollision(Particle particle, Bullet bullet) {
    final dx = particle.position.dx - bullet.position.dx;
    final dy = particle.position.dy - bullet.position.dy;
    final distance = sqrt(dx * dx + dy * dy);

    final combinedRadius = (particle.size + bullet.size) / 2;

    return distance < combinedRadius;
  }

  @override
  bool checkGameOver(
      List<Particle> particles, double screenWidth, double screenHeight) {
    // either the particles are empty or any one particle is in the center of the screen
    final rect = Rect.fromLTWH(screenWidth / 2, screenHeight / 2, 40, 40);
    return particles.isEmpty ||
        particles.any((particle) =>
            rect.contains(Offset(particle.position.dx, particle.position.dy)));
  }
}
