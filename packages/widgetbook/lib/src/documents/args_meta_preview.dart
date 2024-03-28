// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';

import '../../widgetbook.dart';

class ArgsMetaPreview extends StatelessWidget {
  ArgsMetaPreview({
    super.key,
    required this.primaryArgs,
    required this.metaArgs,
  });

  final StoryArgs primaryArgs;
  final List<ArgMeta> metaArgs;

  late final Map<String, Arg> argsMap =
      Map.fromEntries(primaryArgs.safeList.map((e) => MapEntry(e.name, e)));

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        const TableRow(
          children: [
            Text('Name'),
            Text('Type'),
            Text('Description'),
            Text('Default'),
            Text('Knob'),
          ],
        ),
        for (final arg in metaArgs)
          TableRow(
            children: [
              Text(arg.name),
              Text(arg.type),
              Text(arg.docs ?? '-'),
              Text(arg.defaultValue ?? '-'),
              argsMap[arg.name]?.buildFields(context) ?? const Text('-'),
            ],
          ),
      ],
    );
  }
}
