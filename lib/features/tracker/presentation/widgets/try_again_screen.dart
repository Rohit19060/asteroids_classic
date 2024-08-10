import 'package:flutter/material.dart';

class TryAgainScreen extends StatelessWidget {
  const TryAgainScreen({
    super.key,
    required this.onPressed,
    required this.duration,
  });
  final VoidCallback onPressed;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    var durationText = 'You lasted ';
    final inMinutes = duration.inMinutes;
    if (inMinutes > 0) {
      if (inMinutes == 1) {
        durationText += '1 minute and ';
      } else {
        durationText += '$inMinutes minutes and ';
      }
    }
    durationText += '${duration.inSeconds % 60} seconds';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'GAME OVER',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            durationText,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3700d2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 12),
            ),
            onPressed: onPressed,
            child: const Text(
              'Try Again',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
