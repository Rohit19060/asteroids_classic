import '../../features/tracker/domain/entities/particle.dart';
import '../../features/tracker/domain/entities/player.dart';

abstract class CollisionStrategy {
  bool checkCollision(Particle particle, Player player);
}
