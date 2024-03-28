import 'package:flutter/widgets.dart';

import 'arg_meta.dart';
import 'story.dart';
import 'story_args.dart';

class MetaExtra<TWidget extends Widget> {
  const MetaExtra({
    required this.componentDocComment,
    required this.storyDocs,
    required this.constructor,
    required this.args,
  });

  final String? componentDocComment;
  final Map<String, String> storyDocs;

  final String constructor;
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
