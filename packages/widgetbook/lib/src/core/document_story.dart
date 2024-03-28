import 'package:flutter/material.dart';

import '../documents/document_page.dart';
import 'abstract_story.dart';
import 'meta.dart';
import 'meta_extra.dart';
import 'story.dart';
import 'story_args.dart';

@optionalTypeArgs
class DocumentStory<TWidget extends Widget> extends AbstractStory<TWidget> {
  const DocumentStory({
    String? name,
    required this.meta,
    required this.metaExtra,
    required this.stories,
  }) : $name = name;

  final String? $name;
  final Meta<TWidget> meta;
  final MetaExtra<TWidget> metaExtra;
  final List<Story<TWidget, StoryArgs<TWidget>>> stories;

  Widget build(BuildContext context) {
    return DocumentPage(document: this);
  }

  String get name {
    // A safe way to access [$name] in a non-nullable behavior for simplicity.
    // The name should ne provided via constructor or init method.
    assert(
      $name != null,
      'Name must be set via constructor or init method',
    );

    return $name!;
  }

  /// Creates a copy of this using the provided [name] for late initialization.
  /// If [$name] was already set, it should have precedence over [name].
  DocumentStory<TWidget> init({required String name}) {
    return DocumentStory(
      name: $name ?? name,
      meta: meta,
      stories: stories,
      metaExtra: metaExtra,
    );
  }
}
