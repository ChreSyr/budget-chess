import 'dart:async';

import 'package:crea_chess/package/firebase/authentication/auth_uid_listener_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';

final _userUnauthenticated = UserModel(id: '', username: 'userUnauthenticated');
final _noAccountInFirebase = UserModel(id: '', username: 'noAccountInFirebase');

class UserCubit extends AuthUidListenerCubit<UserModel> {
  UserCubit() : super(_userUnauthenticated);

  @override
  void authUidChanged(String? authUid) {
    _userStream?.cancel();

    if (authUid == null) return emit(_userUnauthenticated);

    _userStream = userCRUD
        .stream(documentId: authUid)
        .listen((user) => emit(user ?? _noAccountInFirebase));
  }

  StreamSubscription<UserModel?>? _userStream;

  @override
  Future<void> close() {
    _userStream?.cancel();
    return super.close();
  }

  Future<void> setBanner({required String banner}) async {
    if (state.id.isEmpty) return;
    if (banner == state.banner) return;

    await userCRUD.update(
      documentId: state.id,
      data: state.copyWith(banner: banner),
    );
  }

  Future<void> setPhoto({required String photo}) async {
    if (state.id.isEmpty) return;
    if (photo == state.photo) return;

    await userCRUD.update(
      documentId: state.id,
      data: state.copyWith(photo: photo),
    );
  }

  Future<void> setUsername({required String username}) async {
    if (state.id.isEmpty) return;
    if (username == state.username) return;

    await userCRUD.update(
      documentId: state.id,
      data: state.copyWith(
        username: username,
        usernameLowercase: username.toLowerCase(),
      ),
    );
  }
}
