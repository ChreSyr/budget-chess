// ignore_for_file: public_member_api_docs

import 'package:crea_chess/package/form/form_error.dart';
import 'package:formz/formz.dart';

class InputSelectNullable<T> extends FormzInput<T?, FormError> {
  const InputSelectNullable.pure({this.isRequired = false}) : super.pure(null);

  const InputSelectNullable.dirty({T? value, this.isRequired = false})
      : super.dirty(value);

  final bool isRequired;

  InputSelectNullable<T> copyWith({
    T? value,
    bool? isRequired,
  }) {
    return InputSelectNullable.dirty(
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  FormError? validator(T? value) {
    if (value == null) return isRequired ? FormError.empty : null;
    return null;
  }
}
