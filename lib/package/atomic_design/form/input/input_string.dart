// ignore_for_file: public_member_api_docs

import 'package:crea_chess/package/atomic_design/form/form_error.dart';
import 'package:formz/formz.dart';

class InputString extends FormzInput<String, FormError> {
  const InputString.pure({
    this.isRequired = false,
    this.regexPattern,
  }) : super.pure('');

  const InputString.dirty({
    String string = '',
    this.isRequired = false,
    this.regexPattern,
  }) : super.dirty(string);

  final bool isRequired;
  final String? regexPattern;

  InputString copyWith({
    String? string,
    bool? isRequired,
    String? regexPattern,
  }) {
    return InputString.dirty(
      string: string ?? value,
      isRequired: isRequired ?? this.isRequired,
      regexPattern: regexPattern ?? this.regexPattern,
    );
  }

  @override
  FormError? validator(String value) {
    if (value.isEmpty) return isRequired ? FormError.empty : null;
    if (regexPattern != null && !RegExp(regexPattern!).hasMatch(value)) {
      return FormError.invalid;
    }
    return null;
  }
}
