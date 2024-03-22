import 'package:flutter/material.dart';

import '../core/story.dart';
import '../state/state.dart';
import '../workbench/workbench.dart';

class StoryPreview extends StatefulWidget {
  const StoryPreview({
    super.key,
    required this.story,
    this.primary = false,
    this.docs,
  });

  final Story story;
  final bool primary;
  final String? docs;

  @override
  State<StoryPreview> createState() => _StoryPreviewState();
}

class _StoryPreviewState extends State<StoryPreview> {
  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState(
      addons: WidgetbookState.of(context).addons,
      appBuilder: (context, child) => child,
      components: [],
      integrations: [],
      path: '',
      previewMode: true,
      query: WidgetbookState.of(context).query,
      queryParams: WidgetbookState.of(context).queryParams,
    );

    return WidgetbookScope(
      state: state,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.primary) ...[
            Text(
              widget.story.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 150,
              maxHeight: MediaQuery.sizeOf(context).height / 2,
            ),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(6),
              clipBehavior: Clip.antiAlias,
              child: Workbench(story: widget.story),
            ),
          ),
        ],
      ),
    );
  }
}
