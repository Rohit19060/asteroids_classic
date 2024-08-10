import 'package:flutter/material.dart';

import '../../domain/entities/particle.dart';

class ParticleWidget extends StatelessWidget {
  const ParticleWidget({super.key, required this.particle});
  final Particle particle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      left: particle.position.dx,
      top: particle.position.dy,
      child: Container(
        width: particle.size,
        height: particle.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
