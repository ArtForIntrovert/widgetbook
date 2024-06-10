import 'package:flutter/material.dart';

import '../widgets/panel.dart';

class NoArgsBottomBar extends StatelessWidget {
  const NoArgsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).focusColor, width: 2),
            ),
          ),
          child: const Panel(
            margin: EdgeInsets.only(top: 4),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: const Text('No args for this story'),
            ),
          ),
        ),
      ),
    );
  }
}
