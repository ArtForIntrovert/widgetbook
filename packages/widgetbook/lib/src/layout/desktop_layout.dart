import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings_list.dart';
import '../toolbar/toolbar.dart';
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
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
        separatorColor: Colors.white24,
        children: [
          ExcludeSemantics(
            child: Card(
              child: navigationBuilder(context),
            ),
          ),
          Column(
            children: [
              const ExcludeSemantics(
                child: Toolbar(),
              ),
              Expanded(child: workbench),
            ],
          ),
          ExcludeSemantics(
            child: Card(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Addons'),
                        Tab(text: 'Args'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SettingsList(
                            name: 'Addons',
                            builder: addonsBuilder,
                          ),
                          SettingsList(
                            name: 'Args',
                            builder: argsBuilder,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
