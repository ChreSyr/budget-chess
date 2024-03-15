// ignore_for_file: public_member_api_docs

import 'package:crea_chess/package/atomic_design/form/form_error.dart';
import 'package:formz/formz.dart';

class InputBoolean extends FormzInput<bool, FormError> {
  const InputBoolean.pure({this.isRequired = false}) : super.pure(false);

  const InputBoolean.dirty({
    bool boolean = false,
    this.isRequired = false,
  }) : super.dirty(boolean);

  final bool isRequired;

  InputBoolean copyWith({
    bool? boolean,
    bool? isRequired,
  }) {
    return InputBoolean.dirty(
      boolean: boolean ?? value,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  FormError? validator(bool value) {
    return isRequired && value == false ? FormError.empty : null;
  }
}
