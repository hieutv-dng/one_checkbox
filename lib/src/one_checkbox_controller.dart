part of 'package:one_checkbox/one_checkbox.dart';

class OneCheckboxController extends ValueNotifier<OneCheckboxValue> {
  OneCheckboxController({
    bool isEnable = true,
    bool isChecked = false,
    String? label,
  }) : super(OneCheckboxValue(
          isEnable: isEnable,
          isChecked: isChecked,
        ));

  OneCheckboxController.fromValue(OneCheckboxValue value) : super(value);

  bool get isEnable => value.isEnable;
  bool get isChecked => value.isChecked;

  set isEnable(bool isEnable) => value = value.copyWith(isEnable: isEnable);
  set isChecked(bool? isChecked) => value = value.copyWith(isChecked: isChecked);

  @override
  set value(OneCheckboxValue newValue) {
    super.value = newValue;
  }
}
