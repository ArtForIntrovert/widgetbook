import 'package:flutter/material.dart';

import '../core/abstract_story.dart';
import '../core/document.dart';
import '../core/story.dart';
import '../state/state.dart';
import 'addons_builder.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  const Workbench({super.key, this.story});

  final AbstractStory? story;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final app = state.appBuilder(
      context,
      ColoredBox(
        // Background color for the area behind device frame if
        // the [DeviceFrameAddon] is used.
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Builder(
          builder: (context) {
            final story = this.story ?? WidgetbookState.of(context).story;
            return AddonsBuilder(
              addons: story == null || story is Story ? state.addons : [],
              child: Stack(
                // The Stack is used to loosen the constraints of
                // the UseCaseBuilder. Without the Stack, UseCaseBuilder
                // would expand to the whole size of the Workbench.
                children: [
                  Builder(
                    key: ValueKey(state.uri),
                    builder: (context) {
                      return switch (story) {
                        Document story => story.build(context),
                        Story story => story.build(context),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    if (story != null) {
      return app;
    }

    return Scaffold(
      // Some addons require a Scaffold to work properly.
      body: SafeBoundaries(
        child: app,
      ),
    );
  }
}
