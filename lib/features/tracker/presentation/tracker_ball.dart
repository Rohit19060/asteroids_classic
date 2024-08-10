import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/collision/collision_strategy.dart';
import '../data/datasources/particle_local_datasource.dart';
import '../data/repositories/particle_repository_impl.dart';
import '../domain/entities/particle.dart';
import '../domain/entities/player.dart';
import '../domain/usecases/check_collision.dart';
import '../domain/usecases/generate_particles.dart';
import 'widgets/particle_widget.dart';
import 'widgets/player_widget.dart';
import 'widgets/timer_widget.dart';
import 'widgets/try_again_screen.dart';

class TrackerBall extends StatefulWidget {
  const TrackerBall({super.key});

  @override
  State<TrackerBall> createState() => _TrackerBallState();
}

class _TrackerBallState extends State<TrackerBall>
    with SingleTickerProviderStateMixin {
  final _player = Player(
      position: (dx: 100, dy: 100), size: const Size(30, 30), radius: 15);
  List<Particle> _particles = [];
  late final Ticker _ticker;

  int count = 1;
  double minSize = 20, maxSize = 50;
  bool _isGameOver = false;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeParticles();
      _ticker = createTicker((x) {
        if (!_isGameOver) {
          _duration = x;
        }
        _updateParticles();
      });
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
    final collisionStrategy = CircleCollisionStrategy();
    final checkCollision = CheckCollision(collisionStrategy);
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
    if (checkCollision.checkForCollisions(_particles, _player)) {
      _endGame();
    }
    setState(() {});
  }

  void _endGame() {
    _isGameOver = true;
    _ticker.stop();
    setState(() {});
  }

  void _restartGame() {
    _initializeParticles();
    _isGameOver = false;
    _ticker.start();
    setState(() {});
  }

  void _updateBallPosition(PointerEvent details) {
    if (_isGameOver) {
      return;
    }
    setState(() =>
        _player.position = (dx: details.position.dx, dy: details.position.dy));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isGameOver) {
      return TryAgainScreen(
        onPressed: _restartGame,
        duration: _duration,
      );
    }

    return Stack(
      children: [
        TimerWidget(duration: _duration),
        MouseRegion(onHover: _updateBallPosition),
        ..._particles
            .map((particle) => ParticleWidget(particle: particle))
            .toList(),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 60),
          left: _player.position.dx - 12,
          top: _player.position.dy - 12,
          child: PlayerWidget(
            player: _player,
          ),
        ),
      ],
    );
  }
}
