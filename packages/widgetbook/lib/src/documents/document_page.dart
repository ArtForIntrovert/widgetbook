import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../core/document.dart';
import 'args_meta_preview.dart';
import 'story_preview.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key, required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    final primary =
        document.stories.firstWhereOrNull((element) => element.primary) ??
            document.stories.first;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            document.meta.name,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          if (document.generated.docs != null) ...[
            const SizedBox(height: 16),
            Text(document.generated.docs!.replaceAll(r'\n', '\n')),
          ],
          const SizedBox(height: 16),
          StoryPreview(
            primary: true,
            story: primary,
            docs: document.generated.getStoryDescription(primary),
          ),
          const SizedBox(height: 16),
          ArgsMetaPreview(
            primaryArgs: primary.args,
            metaArgs: document.generated.args,
          ),
          const SizedBox(height: 40),
          if (document.stories.isNotEmpty)
            Text(
              'Stories',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          const SizedBox(height: 12),
          for (final story in document.stories)
            if (!story.primary)
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: StoryPreview(
                  story: story,
                  docs: document.generated.getStoryDescription(story),
                ),
              ),
        ],
      ),
    );
  }
}
