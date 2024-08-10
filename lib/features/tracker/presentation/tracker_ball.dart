import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/collision/collision_strategy.dart';
import '../data/datasources/particle_local_datasource.dart';
import '../data/repositories/particle_repository_impl.dart';
import '../domain/entities/bullet.dart';
import '../domain/entities/particle.dart';
import '../domain/entities/player.dart';
import '../domain/usecases/check_collision.dart';
import '../domain/usecases/generate_particles.dart';
import 'widgets/bullet_widget.dart';
import 'widgets/cursor_widget.dart';
import 'widgets/particle_polygon_widget.dart';
import 'widgets/particle_widget.dart';
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
    size: const Size(30, 30),
    radius: 15,
    rotation: 0,
  );
  List<Particle> _particles = [];
  final List<Widget> _particleWidgets = [];
  final List<Bullet> _bullets = [];
  late final Ticker _ticker;

  int count = 10;
  double minSize = 10, maxSize = 100;
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
    _particleWidgets.addAll(List.generate(
        count, (_) => const RandomPolygonWidget(size: Size(100, 100))));
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
    _bullets.removeWhere((bullet) =>
        bullet.position.dx < 0 ||
        bullet.position.dx > size.width ||
        bullet.position.dy < 0 ||
        bullet.position.dy > size.height);

    for (final bullet in _bullets) {
      bullet.position = Offset(bullet.position.dx + bullet.velocity.dx,
          bullet.position.dy + bullet.velocity.dy);
    }

    checkCollision.checkForCollisionsWithBullets(_particles, _bullets);
    if (checkCollision.checkGameOver(_particles, size.width, size.height)) {
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
    _bullets.clear();
    _isGameOver = false;
    _ticker.start();
    setState(() {});
  }

  void _shootBullet() {
    if (_isGameOver) {
      return;
    }
    final size = MediaQuery.sizeOf(context);
    final position = Offset(size.width / 2, size.height / 2);
    final velocity = Offset.fromDirection(
        _player.rotation - (pi / 2), 8); // Adjust speed as needed
    _bullets.add(Bullet(position: position, velocity: velocity));
  }

  void _updateBallPosition(PointerEvent details) {
    if (_isGameOver) {
      return;
    }
    _player.rotation = _calculateRotation(details.position);
    setState(() {});
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  double _calculateRotation(Offset pointerPosition) {
    final size = MediaQuery.sizeOf(context);
    // Calculate the center of the widget
    final center = Offset(size.width / 2, size.height / 2);

    // Calculate the angle between the center and the pointer position
    final angle = (pointerPosition - center).direction;

    return angle + pi / 2;
  }

  @override
  Widget build(BuildContext context) {
    if (_isGameOver) {
      return TryAgainScreen(
        onPressed: _restartGame,
        duration: _duration,
      );
    }

    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onPanEnd: (details) => _shootBullet(),
      child: Stack(
        children: [
          TimerWidget(duration: _duration),
          MouseRegion(
            onHover: _updateBallPosition,
          ),
          ..._particles.map((x) => ParticleWidget(particle: x)).toList(),
          ..._bullets.map((bullet) => BulletWidget(bullet: bullet)).toList(),
          Positioned(
            left: size.width / 2,
            top: size.height / 2,
            child: CursorWidget(
              size: _player.size,
              rotation:
                  _player.rotation, // Adjust the direction of the pointing
            ),
          ),
        ],
      ),
    );
  }
}
