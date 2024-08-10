import '../../features/tracker/domain/entities/bullet.dart';
import '../../features/tracker/domain/entities/particle.dart';

abstract class CollisionStrategy {
  bool checkCollision(Particle particle, Bullet bullet);

  bool checkGameOver(
      List<Particle> particles, double screenWidth, double screenHeight);
}
