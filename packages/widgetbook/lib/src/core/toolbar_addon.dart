import 'package:flutter/material.dart';

import 'addon.dart';

mixin ToolbarAddonMixin<T> on Addon<T> {
  List<Widget> get actions;
}
