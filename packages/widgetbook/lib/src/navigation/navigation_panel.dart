import 'package:flutter/material.dart';

import '../core/core.dart';
import '../state/state.dart';
import 'navigation_tree_node.dart';
import 'search_field.dart';
import 'tree_node.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({
    super.key,
    this.initialPath,
    this.onStoryTap,
    required this.root,
  });

  final String? initialPath;
  final ValueChanged<TreeNode<Story>>? onStoryTap;
  final TreeNode<Null> root;

  @override
  Widget build(BuildContext context) {
    final query = WidgetbookState.of(context).query ?? '';
    final filteredRoot = root.filter(
      (node) {
        final regex = RegExp(query, caseSensitive: false);
        return query.isEmpty || node.name.contains(regex);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchField(
            value: query,
            onChanged: WidgetbookState.of(context).updateQuery,
            onCleared: () => WidgetbookState.of(context).updateQuery(''),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: NavigationTreeNode(
                node: filteredRoot ?? root,
                onStoryTap: onStoryTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
