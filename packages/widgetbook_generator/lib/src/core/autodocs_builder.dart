import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;

import 'extensions.dart';

class AutodocsBuilder {
  AutodocsBuilder(this.widgetType, this.stories, this.path);

  final String path;
  final DartType widgetType;
  final List<TopLevelVariableElement> stories;

  Code build() {
    return Block.of([
      const Code('// ignore: strict_raw_type'),
      declareFinal('\$${widgetType.nonGenericName}AutoDocs')
          .assign(
            InvokeExpression.newOf(
              TypeReference(
                (b) => b
                  ..symbol = 'Document'
                  ..types.add(refer(widgetType.nonGenericName)),
              ),
              [],
              {
                'name': literalString('Docs'),
                'meta': refer('meta').property('init').call(
                  [],
                  {'path': literalString(navPath)},
                ),
                'generated': refer(
                  '\$${widgetType.nonGenericName}GeneratedMeta',
                ),
                'stories': literalList(
                  stories
                      .map(
                        (story) => refer(story.name).property('init').call(
                          [],
                          {
                            'name': literalString(story.name.substring(1)),
                          },
                        ),
                      )
                      .toList(),
                ),
              },
            ),
          )
          .statement,
    ]);
  }

  /// Gets the navigation path based on [widgetType], skipping both
  /// the `package:` and the `src` parts.
  ///
  /// For example, `package:my_app/src/widgets/foo/bar.dart`
  /// will be converted to `widgets/foo`.
  String get navPath {
    final directory = p.dirname(path);
    final parts = p.split(directory);
    final hasSrc = parts.length >= 2 && parts[1] == 'src';

    return parts.skip(hasSrc ? 2 : 1).join('/');
  }
}
