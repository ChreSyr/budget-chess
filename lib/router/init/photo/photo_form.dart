import 'package:crea_chess/package/atomic_design/form/form_error.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_string.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_form.freezed.dart';

enum PhotoFormStatus {
  inProgress,

  // show progress indicator
  waiting,

  // show error under form fields
  editError,

  // show error in snack bar
  unexpectedError,

  // name modified
  success,
}

@freezed
class PhotoForm with FormzMixin, _$PhotoForm {
  factory PhotoForm({
    required InputString photo,
    required PhotoFormStatus status,
  }) = _PhotoForm;

  /// Required for the override getter
  const PhotoForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [photo];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status != PhotoFormStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    return l10n.formError(input.error!.name);
  }
}

class PhotoFormCubit extends Cubit<PhotoForm> {
  PhotoFormCubit(this.initialPhoto)
      : super(
          PhotoForm(
            photo: InputString.dirty(
              string: initialPhoto,
              isRequired: true,
            ),
            status: PhotoFormStatus.inProgress,
          ),
        );

  final String initialPhoto;

  void clearStatus() {
    emit(state.copyWith(status: PhotoFormStatus.inProgress));
  }

  void setPhoto(String photo) {
    emit(state.copyWith(photo: state.photo.copyWith(string: photo)));
  }

  Future<void> submit() async {
    final newPhoto = state.photo.value;

    if (state.isNotValid) {
      return emit(state.copyWith(status: PhotoFormStatus.editError));
    }

    emit(state.copyWith(status: PhotoFormStatus.waiting));

    try {
      await userCRUD.userCubit.setPhoto(photo: newPhoto);
      emit(state.copyWith(status: PhotoFormStatus.success));
    } catch (e) {
      if (e.toString() ==
          'Bad state: Cannot emit new states after calling close') {
        return;
      }
      emit(state.copyWith(status: PhotoFormStatus.unexpectedError));
    }
  }

  Future<void> waitPhoto(Future<void> Function() getPhoto) async {
    emit(state.copyWith(status: PhotoFormStatus.waiting));
    await getPhoto();
    emit(state.copyWith(status: PhotoFormStatus.inProgress));
  }
}
