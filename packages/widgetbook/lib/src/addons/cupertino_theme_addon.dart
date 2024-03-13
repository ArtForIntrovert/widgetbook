import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../core/toolbar_addon.dart';
import '../fields/fields.dart';
import '../toolbar/widgets/toolbar_button.dart';
import '../toolbar/widgets/toolbar_dropdown_button.dart';

class CupertinoThemeMode extends Mode<CupertinoThemeData> {
  CupertinoThemeMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return CupertinoTheme(
      data: value,
      child: ColoredBox(
        color: value.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: value.textTheme.textStyle,
          child: child,
        ),
      ),
    );
  }
}

/// An [Addon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
class CupertinoThemeAddon extends ModeAddon<CupertinoThemeData>
    with ToolbarAddonMixin {
  CupertinoThemeAddon(this.themes)
      : super(
          name: 'Cupertino Theme',
          modeBuilder: CupertinoThemeMode.new,
        );

  final Map<String, CupertinoThemeData> themes;

  @override
  List<Field> get fields {
    return [
      ListField<CupertinoThemeData>(
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
  CupertinoThemeData valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
  }

  @override
  List<Widget> get actions {
    final field = fields.single as ListField<ThemeData>;

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
