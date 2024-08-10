import 'package:flutter/material.dart';

import 'widgets/player.dart';

class TrackerBall extends StatefulWidget {
  const TrackerBall({super.key});

  @override
  State<TrackerBall> createState() => _TrackerBallState();
}

class _TrackerBallState extends State<TrackerBall> {
  Offset _ballPosition = const Offset(100, 100);

  void _updateBallPosition(PointerEvent details) {
    setState(() => _ballPosition = details.position);
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          MouseRegion(onHover: _updateBallPosition),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 60),
            left: _ballPosition.dx - 25,
            top: _ballPosition.dy - 25,
            child: const Player(),
          ),
        ],
      );
}
