import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_boolean.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_string.dart';
import 'package:crea_chess/package/atomic_design/form/signup/signup_form.dart';
import 'package:crea_chess/package/atomic_design/form/signup/signup_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class SignupCubit extends Cubit<SignupForm> {
  SignupCubit()
      : super(
          SignupForm(
            email: InputString.pure(
              isRequired: true,
              regexPattern: RegexPattern.email,
            ),
            password: InputString.pure(
              isRequired: true,
              regexPattern: RegexPattern.passwordNormal3,
            ),
            acceptConditions: const InputBoolean.pure(isRequired: true),
            status: SignupStatus.inProgress,
          ),
        );

  void clearFailure() {
    emit(state.copyWith(status: SignupStatus.inProgress));
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: state.email.copyWith(string: value.toLowerCase()),
      ),
    );
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: state.password.copyWith(string: value)));
  }

  // ignore: avoid_positional_boolean_parameters
  void acceptedConditionsChanged(bool? boolean) {
    emit(
      state.copyWith(
        acceptConditions: state.acceptConditions.copyWith(boolean: boolean),
      ),
    );
  }

  Future<void> submit() async {
    if (!state.isValid) {
      return emit(state.copyWith(status: SignupStatus.editError));
    }

    emit(state.copyWith(status: SignupStatus.waiting));

    try {
      await authenticationCRUD.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: SignupStatus.signupSuccess));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(state.copyWith(status: SignupStatus.mailTaken));
      } else {
        emit(state.copyWith(status: SignupStatus.unexpectedError));
      }
    } catch (_) {
      emit(state.copyWith(status: SignupStatus.unexpectedError));
    }
  }
}
