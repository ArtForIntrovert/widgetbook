import 'package:flutter/material.dart';

// TODO(@melvspace): 03/28/24 solve proxied docs problem. currently docs rendered as is.

/// {@template generic_text.class_definition}
/// Generic text widget.
/// {@endtemplate}
class GenericText extends StatelessWidget {
  const GenericText({super.key, required this.text});

  /// {@template generic_text.text_field}
  /// Text to represent.
  /// {@endtemplate}
  final String text;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/// {@macro generic_text.class_definition}
class SpecificText extends StatelessWidget {
  const SpecificText({super.key, required this.text});

  /// {@macro generic_text.text_field}
  final String text;

  @override
  Widget build(BuildContext context) {
    return GenericText(text: text);
  }
}
