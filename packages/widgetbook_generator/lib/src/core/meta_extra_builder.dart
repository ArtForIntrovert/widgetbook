import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'extensions.dart';

class MetaExtraBuilder {
  MetaExtraBuilder(
    this.widgetType,
    this.stories,
  );

  final DartType widgetType;
  final List<TopLevelVariableElement> stories;

  Iterable<ParameterElement> get params {
    return (widgetType.element as ClassElement).constructors.first.parameters;
  }

  Code build() {
    final docs = convertDocComment(widgetType.element?.documentationComment);
    final constructor = widgetType.getDisplayString(withNullability: false);
    final argDocs = params.map(
      (e) {
        return InvokeExpression.newOf(
          TypeReference((b) => b..symbol = 'ArgMeta'),
          [],
          {
            'name': literalString(e.name),
            'type': literalString(buildParameterType(e)),
            'docs': convertDocComment(e.documentationComment) ?? literalNull,
            'defaultValue': e.defaultValueCode != null
                ? literalString(e.defaultValueCode!)
                : literalNull,
            'required': literalBool(e.isRequired),
            'named': literalBool(e.isNamed),
          },
        );
      },
    );
    final storyDocs = {
      for (final story in this.stories)
        if (story.documentationComment?.isNotEmpty == true)
          literalString(story.name.substring(1)):
              convertDocComment(story.documentationComment),
    };

    return Block.of([
      const Code('// ignore: strict_raw_type'),
      declareFinal('\$${widgetType.nonGenericName}MetaExtra')
          .assign(
            InvokeExpression.newOf(
              TypeReference(
                (b) => b
                  ..symbol = 'MetaExtra'
                  ..types.add(refer(widgetType.nonGenericName)),
              ),
              [],
              {
                'componentDocComment': docs ?? literalNull,
                'constructor': literalString(constructor),
                'storyDocs': literalMap(storyDocs),
                'args': literalList(argDocs),
              },
            ),
          )
          .statement,
    ]);
  }

  Expression? convertDocComment(String? doc) {
    if (doc == null || doc.replaceAll('///', '').isEmpty) return null;
    final value = doc
        .replaceAll(RegExp(r'^///\s?\n', multiLine: true), '\n')
        .replaceAll(RegExp(r'^///\s?', multiLine: true), '')
        .replaceAll('\'', '"');

    return literalString(value, raw: true);
  }

  String buildParameterType(ParameterElement param) {
    final generic =
        widgetType.getTypeParams().whereType<TypeReference>().firstWhereOrNull(
              (type) =>
                  type.bound != null &&
                  type.symbol ==
                      param.type.getDisplayString(withNullability: false),
            );

    return switch (generic) {
      TypeReference(:final symbol, :Reference bound)
          when param.type.isNullable =>
        '(${symbol} extends ${bound.symbol})?',
      TypeReference(:final symbol, :Reference bound) =>
        '${symbol} extends ${bound.symbol}',
      _ => param.type.getDisplayString(withNullability: true),
    };
  }
}
