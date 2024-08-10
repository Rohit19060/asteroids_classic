import '../../domain/entities/particle.dart';
import '../../domain/repositories/particle_repository.dart';
import '../datasources/particle_local_datasource.dart';

class ParticleRepositoryImpl implements ParticleRepository {
  ParticleRepositoryImpl({required this.localDataSource});
  final ParticleLocalDataSource localDataSource;

  @override
  List<Particle> generateParticles(int count, double minSize, double maxSize) =>
      localDataSource.generateParticles(count, minSize, maxSize);
}
