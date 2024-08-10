// lib/features/tracker/domain/entities/bullet.dart

import 'package:flutter/material.dart';

class Bullet {
  Bullet({
    required this.position,
    required this.velocity,
    this.size = 10.0,
  });

  Offset position;
  Offset velocity;
  final double size;
}
