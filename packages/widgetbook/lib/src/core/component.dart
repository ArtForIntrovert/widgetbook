import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

import 'abstract_story.dart';
import 'document.dart';
import 'meta.dart';
import 'story.dart';
import 'story_args.dart';

class Component<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Component({
    required this.meta,
    required this.stories,
    this.documents,
  });

  final Meta<TWidget> meta;
  final List<Document<TWidget>>? documents;
  final List<Story<TWidget, TArgs>> stories;

  String get name => meta.name;
  String? get path => meta.path;

  String pathOf(AbstractStory story) {
    return p.join(path ?? '', name, story.name).replaceAll(' ', '-');
  }
}
