import 'dart:math';
import 'dart:ui';

import '../models/particle_model.dart';

class ParticleLocalDataSource {
  ParticleLocalDataSource(this.screenSize);

  final Size screenSize;

  final _random = Random();

  List<ParticleModel> generateParticles(
          int count, double minSize, double maxSize) =>
      List.generate(
        count,
        (index) {
          final size = minSize + _random.nextDouble() * (maxSize - minSize);
          final position = Offset(
            _random.nextDouble() * screenSize.width, // Screen width (tunable)
            _random.nextDouble() * screenSize.height, // Screen height (tunable)
          );
          final velocity = Offset(
            _random.nextDouble() * 2 - 1, // Velocity x (-1 to 1)
            _random.nextDouble() * 2 - 1, // Velocity y (-1 to 1)
          );


          return ParticleModel(
            radius: size / 2,
            size: size,
            position: (dx: position.dx, dy: position.dy),
            velocity: (dx: velocity.dx, dy: velocity.dy),
          );
        },
      );
}
