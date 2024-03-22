import 'dart:math';

import 'package:flutter/material.dart';

class DocumentIcon extends StatelessWidget {
  const DocumentIcon({
    super.key,
    this.size = 14,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45 * pi / 180,
      child: Icon(
        Icons.description,
        size: size,
      ),
    );
  }
}
