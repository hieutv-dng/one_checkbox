part of 'package:one_checkbox/one_checkbox.dart';

class OneCheckboxValue {
  const OneCheckboxValue({
    this.isEnable = true,
    this.isChecked = false,
  });

  final bool isEnable;
  final bool isChecked;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OneCheckboxValue empty = OneCheckboxValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneCheckboxValue copyWith({
    bool? isEnable,
    bool? isChecked,
  }) {
    return OneCheckboxValue(
      isEnable: isEnable ?? this.isEnable,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
