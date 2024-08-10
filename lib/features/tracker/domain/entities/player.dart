import 'package:flutter/material.dart';

class Player {
  Player({
    required this.position,
    required this.size,
    this.radius = 0.0,
  });

  ({double dx, double dy}) position;
  Size size;
  double radius;
}
