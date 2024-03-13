import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../field.dart';
import '../field_codec.dart';
import '../field_type.dart';
import 'alignment_picker.dart';

class AlignmentField extends Field<Alignment> {
  AlignmentField({
    required super.name,
    required super.initialValue,
  }) : super(
          type: FieldType.string,
          codec: FieldCodec(
            toParam: (value) => AlignmentPicker.alignments[value]!,
            toValue: (param) {
              return AlignmentPicker.alignments.entries
                      .firstWhereOrNull((element) => element.value == param)
                      ?.key ??
                  initialValue;
            },
          ),
        );

  @override
  Widget toWidget(BuildContext context, String group, Alignment? value) {
    return AlignmentPicker(
      value: value ?? initialValue ?? Alignment.center,
      onChanged: (value) => updateField(context, group, value),
    );
  }
}
