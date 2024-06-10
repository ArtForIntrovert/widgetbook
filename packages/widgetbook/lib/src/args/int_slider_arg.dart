import 'package:widgetbook/widgetbook.dart';

class IntSliderArg extends Arg<int> {
  final int min;
  final int max;

  const IntSliderArg(
    super.value, {
    super.name,
    required this.min,
    required this.max,
  });

  @override
  List<Field> get fields => [
        IntSliderField(
          name: name,
          initialValue: value,
          min: min,
          max: max,
        ),
      ];

  @override
  int valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  IntSliderArg init({required String name}) {
    return IntSliderArg(
      value,
      name: $name ?? name,
      min: min,
      max: max,
    );
  }
}

class NullableIntSliderArg extends NullableArg<int> {
  final int min;
  final int max;

  NullableIntSliderArg(
    super.value, {
    super.name,
    required this.min,
    required this.max,
  });

  @override
  List<Field> get fields => [
        IntSliderField(
          name: name,
          initialValue: value,
          min: min,
          max: max,
        ),
      ];

  @override
  int? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group);
  }

  @override
  NullableIntSliderArg init({required String name}) {
    return NullableIntSliderArg(
      value,
      name: $name ?? name,
      min: min,
      max: max,
    );
  }
}
