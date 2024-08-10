// lib/features/tracker/presentation/widgets/bullet_widget.dart

import 'package:flutter/material.dart';

import '../../domain/entities/bullet.dart';

class BulletWidget extends StatelessWidget {
  const BulletWidget({super.key, required this.bullet});
  final Bullet bullet;

  @override
  Widget build(BuildContext context) => Positioned(
        left: bullet.position.dx - bullet.size / 2,
        top: bullet.position.dy - bullet.size / 2,
        child: Container(
          width: bullet.size,
          height: bullet.size,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      );
}
