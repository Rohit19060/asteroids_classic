import '../entities/particle.dart';
import '../repositories/particle_repository.dart';

class GenerateParticles {
  GenerateParticles(this.repository);
  final ParticleRepository repository;

  List<Particle> call(int count, double minSize, double maxSize) =>
      repository.generateParticles(count, minSize, maxSize);
}
