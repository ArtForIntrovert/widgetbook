import 'package:widgetbook/widgetbook.dart';

class DoubleSliderArg extends Arg<double> {
  final double min;
  final double max;
  final double step;

  const DoubleSliderArg(
    super.value, {
    super.name,
    required this.min,
    required this.max,
    this.step = 1,
  });

  @override
  List<Field> get fields => [
        DoubleSliderField(
          name: name,
          initialValue: value,
          min: min,
          max: max,
          divisions: (max - min) ~/ step,
        ),
      ];

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  DoubleSliderArg init({required String name}) {
    return DoubleSliderArg(
      value,
      name: $name ?? name,
      min: min,
      max: max,
      step: step,
    );
  }
}
