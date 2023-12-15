// ignore_for_file: public_member_api_docs

import 'package:crea_chess/package/form/form_error.dart';
import 'package:formz/formz.dart';

class InputSelect<T> extends FormzInput<T, FormError> {
  const InputSelect.dirty({required T value}) : super.dirty(value);

  InputSelect<T> copyWith({required T value}) {
    return InputSelect.dirty(value: value);
  }

  @override
  FormError? validator(T value) {
    return null;
  }
}
