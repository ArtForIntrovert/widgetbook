import 'package:flutter/material.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../core/toolbar_addon.dart';
import '../fields/fields.dart';
import '../toolbar/widgets/toolbar_button.dart';
import '../toolbar/widgets/toolbar_dropdown_button.dart';

typedef ThemeBuilder<T> = Widget Function(
  BuildContext context,
  T theme,
  Widget child,
);

class ThemeMode<T> extends Mode<T> {
  ThemeMode(super.value, this.builder);

  final ThemeBuilder<T> builder;

  @override
  Widget build(BuildContext context, Widget child) {
    return builder(context, value, child);
  }
}

/// An [Addon] for changing the active custom theme. A [builder] must be
/// provided that returns an [InheritedWidget] or similar [Widget]s.
class ThemeAddon<T> extends ModeAddon<T> with ToolbarAddonMixin {
  ThemeAddon(this.themes, this.builder)
      : super(
          name: 'Theme',
          modeBuilder: (theme) => ThemeMode(theme, builder),
        );

  final Map<String, T> themes;
  final ThemeBuilder<T> builder;

  @override
  List<Field> get fields {
    return [
      ListField<T>(
        name: 'name',
        values: themes.values.toList(),
        initialValue: themes.values.first,
        labelBuilder: (theme) => themes.keys.firstWhere(
          (key) => themes[key] == theme,
        ),
      ),
    ];
  }

  @override
  T valueFromQueryGroup(Map<String, String> group) {
    return valueOf<T>('name', group)!;
  }

  @override
  List<Widget> get actions {
    final field = fields.single as ListField<T>;

    return [
      Builder(
        builder: (context) {
          return ToolbarDropdownButton(
            items: [
              for (final theme in field.values)
                MenuItemButton(
                  onPressed: () => field.updateField(context, groupName, theme),
                  child: Text(field.labelBuilder(theme)),
                ),
            ],
            tooltip: ToolbarTooltip(message: name),
            child: const Icon(Icons.image_sharp),
          );
        },
      ),
    ];
  }
}
