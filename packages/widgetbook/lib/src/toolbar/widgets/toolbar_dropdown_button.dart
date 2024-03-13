import 'package:flutter/material.dart';

import 'toolbar_button.dart';

class ToolbarDropdownButton extends StatefulWidget {
  const ToolbarDropdownButton({
    super.key,
    required this.child,
    required this.items,
    this.tooltip,
  });

  final Widget child;
  final ToolbarTooltip? tooltip;
  final List<MenuItemButton> items;

  @override
  State<ToolbarDropdownButton> createState() => _ToolbarDropdownButtonState();
}

class _ToolbarDropdownButtonState extends State<ToolbarDropdownButton> {
  final MenuController controller = MenuController();

  void handlePressed() {
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: controller,
      menuChildren: widget.items,
      child: ToolbarButton(
        onPressed: handlePressed,
        tooltip: widget.tooltip,
        child: widget.child,
      ),
    );
  }
}
