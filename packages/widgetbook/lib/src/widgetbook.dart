import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';
import 'integrations/integrations.dart';
import 'routing/routing.dart';
import 'state/state.dart';
import 'themes.dart';

/// Class to override default Widgetbook theme
class WidgetbookTheme {
  const WidgetbookTheme({
    required this.light,
    this.dark,
  });

  final ThemeData light;
  final ThemeData? dark;
}

/// Describes the configuration for your [Widget] library.
///
/// [Widgetbook] is the central element in organizing your widgets into
/// folders and use cases.
///
/// [Widgetbook] defines the following constructors for different app types
/// - [Widgetbook] if you use a custom widget (e.g. [WidgetsApp]) for your app.
/// - [Widgetbook.cupertino] if you use [CupertinoApp] for your app.
/// - [Widgetbook.material] if you use [MaterialApp] for your app.
class Widgetbook extends StatefulWidget {
  const Widgetbook({
    super.key,
    this.initialRoute = '/',
    this.components = const [],
    this.appBuilder = widgetsAppBuilder,
    this.addons,
    this.integrations,
    this.theme,
  });

  /// A [Widgetbook] with [CupertinoApp] as an [appBuilder].
  const Widgetbook.cupertino({
    super.key,
    this.initialRoute = '/',
    this.components = const [],
    this.appBuilder = cupertinoAppBuilder,
    this.addons,
    this.integrations,
    this.theme,
  });

  /// A [Widgetbook] with [MaterialApp] as an [appBuilder].
  const Widgetbook.material({
    super.key,
    this.initialRoute = '/',
    this.components = const [],
    this.appBuilder = materialAppBuilder,
    this.addons,
    this.integrations,
    this.theme,
  });

  /// The initial route for that will be used on first startup.
  final String initialRoute;

  final List<Component> components;

  /// A wrapper builder method for all [WidgetbookUseCase]s.
  final AppBuilder appBuilder;

  /// The list of add-ons for your [Widget] library
  final List<Addon>? addons;

  /// The list of integrations for your [Widget] library. Primarily used to
  /// integrate with Widgetbook Cloud via [WidgetbookCloudIntegration], but
  /// can also be used to integrate with third-party packages.
  final List<WidgetbookIntegration>? integrations;

  /// Widgetbook theme
  final WidgetbookTheme? theme;

  @override
  State<Widgetbook> createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
  late final WidgetbookState state;
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    state = WidgetbookState(
      appBuilder: widget.appBuilder,
      addons: widget.addons,
      integrations: widget.integrations,
      components: widget.components,
    );

    router = AppRouter(
      initialRoute: Uri.base.fragment.isNotEmpty
          ? Uri.base.fragment
          : widget.initialRoute,
      state: state,
    );

    widget.integrations?.forEach(
      (integration) => integration.onInit(state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetbookScope(
      state: state,
      child: MaterialApp.router(
        title: 'Widgetbook',
        theme: widget.theme?.light ?? Themes.light,
        darkTheme: widget.theme != null ? widget.theme!.dark : Themes.dark,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
