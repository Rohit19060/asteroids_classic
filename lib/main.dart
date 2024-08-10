import 'package:flutter/material.dart';

import 'core/utils/theme.dart';
import 'features/tracker/presentation/pages/tracker_ball_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Asteroids Classic',
      theme: darkTheme,
      home: const TrackerBallPage(),
    );
}
