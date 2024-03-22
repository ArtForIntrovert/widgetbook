import 'package:flutter/widgets.dart';

import '../../widgetbook.dart';

class Meta<T> {
  const Meta({
    String? name,
    String? path,
  })  : name = name ?? '$T',
        $path = path;

  final String name;
  final String? $path;

  String? get path => $path;

  /// Creates a copy of this using the provided [path] for late initialization.
  /// If [$path] was already set, it should have precedence over [path].
  Meta<T> init({
    required String path,
  }) {
    final genericRegex = RegExp(r'<.*>');
    return Meta<T>(
      name: name.replaceAll(genericRegex, ''),
      path: $path ?? path,
    );
  }
}

/// Same as [Meta] but for custom [StoryArgs].
class MetaWithArgs<TWidget, TArgs> extends Meta<TWidget> {
  const MetaWithArgs({
    super.name,
    super.path,
  });
}

class GeneratedMeta<TWidget extends Widget> {
  const GeneratedMeta({
    required this.docs,
    required this.constructor,
    required this.storyDocs,
    required this.args,
  });

  final String? docs;
  final String constructor;
  final Map<String, String> storyDocs;
  final List<ArgMeta> args;

  String? getStoryDescription(Story<TWidget, StoryArgs<TWidget>> story) {
    return storyDocs[story.name];
  }

  String buildCodeFor(Story<TWidget, StoryArgs<TWidget>> story) {
    final args = story.args.list
        .map(
          (e) => '${e!.name}: ${e.value}',
        )
        .join(',\n');

    return '$constructor(${args.length > 1 ? '\n\t$args\n' : args})';
  }
}

class ArgMeta {
  const ArgMeta({
    required this.name,
    required this.type,
    required this.docs,
    required this.defaultValue,
    required this.required,
    required this.named,
  });

  final String name;
  final String type;
  final String? docs;
  final String? defaultValue;
  final bool required;
  final bool named;
}
