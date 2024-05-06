import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class Panel extends SingleChildStatelessWidget {
  const Panel({
    super.key,
    this.margin,
    super.child,
  });

  final EdgeInsets? margin;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Card(
      shape: const LinearBorder(),
      margin: margin ?? EdgeInsets.zero,
      child: child,
    );
  }
}
