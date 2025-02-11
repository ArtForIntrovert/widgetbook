import 'package:flutter/material.dart';

import '../core/core.dart';
import '../state/state.dart';

import 'category_tree_tile.dart';
import 'folder_tree_tile.dart';
import 'tree_node.dart';

class NavigationTreeNode extends StatefulWidget {
  const NavigationTreeNode({
    super.key,
    required this.node,
    this.depth = 0,
    this.onStoryTap,
  });

  final TreeNode node;
  final int depth;
  final ValueChanged<TreeNode<Story>>? onStoryTap;

  @override
  State<NavigationTreeNode> createState() => _NavigationTreeNodeState();
}

class _NavigationTreeNodeState extends State<NavigationTreeNode> {
  late bool isExpanded = widget.node.isRoot || //
      (widget.node.parent?.isRoot ?? false) ||
      (WidgetbookState.of(context).path?.contains(widget.node.path) ?? false);

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final isCategory = node.isCategory;
    final isTerminal = switch (node) {
      TreeNode<Story>() => true,
      TreeNode<Component>() => node.children.length == 1,
      _ => false,
    };

    return Column(
      children: [
        if (node.parent != null) // non-root
          if (isCategory)
            CategoryTreeTile(
              node: node as TreeNode<String>,
              onTap: () {
                setState(() => isExpanded = !isExpanded);
              },
            )
          else
            FolderTreeTile(
              node: node,
              depth: widget.depth,
              isTerminal: isTerminal,
              isExpanded: isExpanded,
              isSelected: switch (node) {
                    _
                        when node.children.length == 1 &&
                            node.children.single.children.isEmpty =>
                      WidgetbookState.of(context).path?.contains(node.path),
                    _ => node.path == WidgetbookState.of(context).path,
                  } ??
                  false,
              onTap: () {
                if (!isTerminal) {
                  setState(() => isExpanded = !isExpanded);
                } else if (node is TreeNode<Story>) {
                  widget.onStoryTap?.call(node);
                } else {
                  // Redirect interactions to the story of the leaf component,
                  // so that when it's clicked, the route is updated to the story
                  // of the leaf component, and not the leaf component itself.
                  final componentNode = node as TreeNode<Component>;
                  widget.onStoryTap?.call(
                    componentNode.children.first as TreeNode<Story>,
                  );
                }
              },
            ),
        if (!isTerminal)
          _SlideAnimator(
            forward: isExpanded,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: node.children.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => NavigationTreeNode(
                depth: isCategory ? widget.depth : widget.depth + 1,
                node: node.children[index],
                onStoryTap: widget.onStoryTap,
              ),
            ),
          ),
      ],
    );
  }
}

class _SlideAnimator extends StatelessWidget {
  const _SlideAnimator({
    required this.forward,
    required this.child,
  });

  final bool forward;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(
      milliseconds: 200,
    );

    return ClipRect(
      child: AnimatedSlide(
        duration: animationDuration,
        curve: Curves.easeInOut,
        offset: Offset(0, forward ? 0 : -1),
        child: AnimatedAlign(
          duration: animationDuration,
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          heightFactor: forward ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
