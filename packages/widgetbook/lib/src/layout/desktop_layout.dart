import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../../widgetbook.dart';
import '../settings/no_args_bottom_bar.dart';
import '../settings/settings_list.dart';
import '../toolbar/toolbar.dart';
import '../widgets/panel.dart';
import 'base_layout.dart';

class DesktopLayout extends StatelessWidget implements BaseLayout {
  const DesktopLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.argsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final args = argsBuilder(context);

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        // TODO(@melvspace): 06/21/24 resizable widget not updating children
        key: ValueKey(args.isEmpty),
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
        separatorColor: Colors.white24,
        children: [
          ExcludeSemantics(
            child: Panel(
              child: navigationBuilder(context),
            ),
          ),
          Column(
            children: [
              const ExcludeSemantics(
                child: Toolbar(),
              ),
              if (args.isNotEmpty)
                Expanded(
                  // TODO(@melvspace): 06/21/24 resizable widget not updating children
                  child: ResizableWidget(
                    isHorizontalSeparator: true,
                    percentages: [
                      .7,
                      .3,
                    ],
                    children: [
                      workbench,
                      ExcludeSemantics(
                        child: Panel(
                          child: SettingsList(
                            name: 'Args',
                            builder: (context) => args,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else ...[
                Expanded(
                  child: workbench,
                ),
                const NoArgsBottomBar(),
              ],
            ],
          ),
          ExcludeSemantics(
            child: Panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 12),
                    child: Text(
                      'Addons',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Expanded(
                    child: SettingsList(
                      name: 'Addon',
                      builder: addonsBuilder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
