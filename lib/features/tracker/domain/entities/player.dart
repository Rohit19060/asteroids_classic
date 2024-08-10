import 'package:flutter/material.dart';

class Player {
  Player({
    required this.position,
    required this.size,
    required this.radius,
    required this.rotation,
  });

  ({double dx, double dy}) position;
  Size size;
  double radius, rotation;
}
