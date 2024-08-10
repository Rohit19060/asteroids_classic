import '../../../../core/collision/circle_collision_strategy.dart';
import '../entities/particle.dart';
import '../entities/player.dart';

class CheckCollision {
  CheckCollision(this.strategy);
  final CollisionStrategy strategy;

  bool checkForCollisions(List<Particle> particles, Player player) {
    for (final particle in particles) {
      if (strategy.checkCollision(particle, player)) {
        return true;
      }
    }
    return false;
  }
}
