import 'package:flutter/material.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../core/toolbar_addon.dart';
import '../fields/alignment_field/alignment_field.dart';
import '../fields/fields.dart';
import '../state/widgetbook_state.dart';
import '../toolbar/widgets/toolbar_button.dart';
import '../toolbar/widgets/toolbar_overlay_button.dart';

class AlignmentMode extends Mode<Alignment> {
  AlignmentMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return Align(
      alignment: value,
      child: child,
    );
  }
}

/// An [Addon] for wrapping use-cases with [Align] widget.
class AlignmentAddon extends ModeAddon<Alignment> with ToolbarAddonMixin {
  AlignmentAddon([this.alignment = Alignment.center])
      : super(
          name: 'Alignment',
          modeBuilder: AlignmentMode.new,
        );

  final Alignment alignment;

  @override
  List<Field> get fields {
    return [
      AlignmentField(
        name: 'alignment',
        initialValue: alignment,
      ),
    ];
  }

  @override
  Alignment valueFromQueryGroup(Map<String, String> group) {
    return valueOf('alignment', group)!;
  }

  @override
  List<Widget> get actions => [
        ToolbarOverlayButton(
          tooltip: ToolbarTooltip(message: name),
          overlay: (context) {
            final state = WidgetbookState.of(context);
            final queryGroup =
                FieldCodec.decodeQueryGroup(state.queryParams[groupName]);
            final value = valueFromQueryGroup(queryGroup);

            return fields.first.toWidget(context, groupName, value);
          },
          child: const Icon(Icons.align_vertical_center_rounded),
        ),
      ];
}
