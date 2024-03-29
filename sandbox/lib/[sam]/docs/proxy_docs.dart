import 'package:flutter/material.dart';

// TODO(@melvspace): 03/28/24 solve proxied docs problem. currently docs rendered as is.

/// {@template generic_text.class_definition}
/// A run of text with a single style.
///
/// The [Text] widget displays a string of text with single style. The string
/// might break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// The [style] argument is optional. When omitted, the text will use the style
/// from the closest enclosing [DefaultTextStyle]. If the given style's
/// [TextStyle.inherit] property is true (the default), the given style will
/// be merged with the closest enclosing [DefaultTextStyle]. This merging
/// behavior is useful, for example, to make the text bold while using the
/// default font family and size.
///
/// This example shows how to display text using the [Text] widget with the
/// [overflow] set to [TextOverflow.ellipsis].
///
/// ![If the text overflows, the Text widget displays an ellipsis to trim the overflowing text](https://flutter.github.io/assets-for-api-docs/assets/widgets/text_ellipsis.png)
///
/// ```dart
/// Container(
///   width: 100,
///   decoration: BoxDecoration(border: Border.all()),
///   child: Text(overflow: TextOverflow.ellipsis, 'Hello $_name, how are you?'))
/// ```
/// {@endtemplate}
class GenericText extends StatelessWidget {
  /// {@template generic_text.constructor}
  /// GenericText constructor:
  ///
  /// - [text] - **required** - [String] - string value to show in widget
  /// {@endtemplate}
  const GenericText({super.key, required this.text});

  /// {@template generic_text.text_field}
  /// Text to represent.
  /// {@endtemplate}
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

/// {@macro generic_text.class_definition}
class SpecificText extends StatelessWidget {
  /// {@macro generic_text.constructor}
  const SpecificText({super.key, required this.text});

  /// {@macro generic_text.text_field}
  final String text;

  @override
  Widget build(BuildContext context) {
    return GenericText(text: text);
  }
}
