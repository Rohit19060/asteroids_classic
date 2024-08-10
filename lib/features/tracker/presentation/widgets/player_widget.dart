import 'package:flutter/material.dart';

import '../../domain/entities/player.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: player.size.width,
      height: player.size.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
