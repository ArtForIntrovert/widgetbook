import 'package:flutter/material.dart';

import '../core/toolbar_addon.dart';
import '../state/state.dart';
import '../widgets/panel.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 40,
              minWidth: double.infinity,
            ),
            child: Panel(
              margin: const EdgeInsets.only(bottom: 4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 4,
                  runAlignment: WrapAlignment.center,
                  children: [
                    for (final addon in state.addons ?? [])
                      if (addon is ToolbarAddonMixin) ...addon.actions,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
