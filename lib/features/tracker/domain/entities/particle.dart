class Particle {
  Particle({
    required this.size,
    required this.position,
    required this.velocity,
  });

  final double size;
  ({double dx, double dy}) position;
  ({double dx, double dy}) velocity;
}
