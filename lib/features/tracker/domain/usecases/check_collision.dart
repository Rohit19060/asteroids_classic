import '../../../../core/collision/circle_collision_strategy.dart';
import '../entities/bullet.dart';
import '../entities/particle.dart';

class CheckCollision {
  CheckCollision(this.strategy);
  final CollisionStrategy strategy;

  bool checkForCollisionsWithBullets(
      List<Particle> particles, List<Bullet> bullets) {
    for (final bullet in bullets) {
      for (final particle in particles) {
        if (strategy.checkCollision(particle, bullet)) {
          particles.remove(particle);
          bullets.remove(bullet);
          return true;
        }
      }
    }
    return false;
  }

  bool checkGameOver(
      List<Particle> particles, double screenWidth, double screenHeight) {
    if (strategy.checkGameOver(particles, screenWidth, screenHeight)) {
      return true;
    }
    return false;
  }
}
