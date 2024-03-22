import 'package:flutter/widgets.dart';

abstract class AbstractStory<TWidget extends Widget> {
  const AbstractStory();

  String get name;
}
