import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../data/datasources/particle_local_datasource.dart';
import '../data/repositories/particle_repository_impl.dart';
import '../domain/entities/particle.dart';
import '../domain/usecases/generate_particles.dart';
import 'widgets/particle_widget.dart';
import 'widgets/player.dart';

class TrackerBall extends StatefulWidget {
  const TrackerBall({super.key});

  @override
  State<TrackerBall> createState() => _TrackerBallState();
}

class _TrackerBallState extends State<TrackerBall>
    with SingleTickerProviderStateMixin {
  Offset _ballPosition = const Offset(100, 100);
  List<Particle> _particles = [];
  late final Ticker _ticker;

  int count = 10;
  double minSize = 20, maxSize = 50;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeParticles();
      _ticker = createTicker((_) => _updateParticles());
      _ticker.start();
    });
  }

  void _initializeParticles() {
    final size = MediaQuery.sizeOf(context);
    final particleRepo =
        ParticleRepositoryImpl(localDataSource: ParticleLocalDataSource(size));
    final generateParticles = GenerateParticles(particleRepo);
    _particles = generateParticles(
        count, minSize, maxSize); // Tunable particle count and size range
  }

  void _updateParticles() {
    final size = MediaQuery.sizeOf(context);
    for (final particle in _particles) {
      particle.position = (
        dx: particle.position.dx + particle.velocity.dx,
        dy: particle.position.dy + particle.velocity.dy
      );

      // Optionally, wrap the particles around the screen or reset their position
      if (particle.position.dx < 0 || particle.position.dx > size.width - 25) {
        particle.velocity =
            (dx: -particle.velocity.dx, dy: particle.velocity.dy);
      }
      if (particle.position.dy < 0 || particle.position.dy > size.height - 25) {
        particle.velocity =
            (dx: particle.velocity.dx, dy: -particle.velocity.dy);
      }
    }
    setState(() {});
  }

  void _updateBallPosition(PointerEvent details) {
    setState(() => _ballPosition = details.position);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          MouseRegion(onHover: _updateBallPosition),
          ..._particles
              .map((particle) => ParticleWidget(particle: particle))
              .toList(),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 60),
            left: _ballPosition.dx - 12,
            top: _ballPosition.dy - 12,
            child: const Player(),
          ),
        ],
      );
}
