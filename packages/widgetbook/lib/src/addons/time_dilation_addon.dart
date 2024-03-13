import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../core/toolbar_addon.dart';
import '../fields/fields.dart';
import '../state/widgetbook_state.dart';
import '../toolbar/widgets/toolbar_button.dart';
import '../toolbar/widgets/toolbar_overlay_button.dart';

/// An [Addon] for changing [timeDilation].
class TimeDilationMode extends Mode<double> {
  TimeDilationMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    timeDilation = value;
    return child;
  }
}

class TimeDilationAddon extends ModeAddon<double> with ToolbarAddonMixin {
  TimeDilationAddon()
      : super(
          name: 'Time Dilation',
          modeBuilder: TimeDilationMode.new,
        );

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: 1,
        min: 0.25,
        max: 16,
        divisions: 16 * 4 - 1,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('factor', group)!;
  }

  @override
  List<Widget> get actions {
    final field = fields.single as DoubleSliderField;
    return [
      Builder(
        builder: (context) {
          return ToolbarOverlayButton(
            overlay: (context) => ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 48, maxWidth: 200),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: field.toWidget(
                  context,
                  groupName,
                  WidgetbookState.of(context).getAddonParams(this),
                ),
              ),
            ),
            tooltip: ToolbarTooltip(message: name),
            child: const Icon(Icons.timer),
          );
        },
      ),
    ];
  }
}
