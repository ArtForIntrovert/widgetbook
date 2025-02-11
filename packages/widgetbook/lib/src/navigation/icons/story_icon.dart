import 'dart:math';

import 'package:flutter/material.dart';

class StoryIcon extends StatelessWidget {
  const StoryIcon({
    super.key,
    this.size = 14,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45 * pi / 180,
      child: Icon(
        Icons.square_rounded,
        size: size,
      ),
    );
  }
}
