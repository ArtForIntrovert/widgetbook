import 'package:flutter/widgets.dart';

import '../core/const_arg.dart';

typedef ArgBuilder<T> = T Function(BuildContext context);

class BuilderArg<T> extends ConstArg<T> {
  const BuilderArg(
    this.builder,
  ) : super.empty();

  final ArgBuilder<T> builder;

  @override
  T resolve(BuildContext context) => builder(context);
}
