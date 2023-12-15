// ignore_for_file: public_member_api_docs

import 'package:crea_chess/package/form/form_error.dart';
import 'package:formz/formz.dart';

class InputInt extends FormzInput<int, FormError> {
  const InputInt.pure({
    this.minBound,
    this.maxBound,
  }) : super.pure(0);

  const InputInt.dirty({
    int value = 0,
    this.minBound,
    this.maxBound,
  }) : super.dirty(value);

  final int? minBound;
  final int? maxBound;

  InputInt copyWith({
    int? value,
    int? minBound,
    int? maxBound,
  }) {
    return InputInt.dirty(
      value: value ?? this.value,
      minBound: minBound ?? this.minBound,
      maxBound: maxBound ?? this.maxBound,
    );
  }

  @override
  FormError? validator(int value) {
    if ((minBound != null) && (value < minBound!)) {
      return FormError.minBound;
    } else if ((maxBound != null) && (value > maxBound!)) {
      return FormError.maxBound;
    }
    return null;
  }
}
