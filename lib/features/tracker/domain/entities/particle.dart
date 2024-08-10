class Particle {
  Particle({
    required this.size,
    required this.position,
    required this.velocity,
    required this.radius,
  });

  final double size, radius;
  ({double dx, double dy}) position;
  ({double dx, double dy}) velocity;
}
