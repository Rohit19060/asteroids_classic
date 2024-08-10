import '../entities/particle.dart';

abstract class ParticleRepository {
  List<Particle> generateParticles(int count, double minSize, double maxSize);
}
