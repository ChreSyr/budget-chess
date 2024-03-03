import 'dart:async';

import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/challenge_filter/challenge_filter_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null) {
    _authStream = FirebaseAuth.instance.userChanges().listen(_fromAuth);
  }

  void _fromAuth(User? auth) {
    _userStream?.cancel();

    if (auth == null || !auth.isVerified) {
      signedOut = true;
      emit(null);
      return;
    }

    _userStream = userCRUD.stream(documentId: auth.uid).listen((user) async {
      if (user == null && auth.displayName != accountBeingDeleted) {
        // Create user
        var username = auth.displayName ?? '';
        username = removeDiacritics(username.replaceAll(' ', '_'));
        if (!RegExp(RegexPattern.usernameV2).hasMatch(username)) {
          username = '';
        }
        if (await userCRUD.usernameIsTaken(username)) {
          username = '';
        }

        try {
          await userCRUD.create(
            documentId: auth.uid,
            data: UserModel(
              id: auth.uid,
              createdAt: DateTime.now(),
              username: username,
              photo: auth.photoURL,
              isConnected: true,
            ),
          );

          challengeFilterCRUD.onAccountCreation(auth.uid);
        } catch (e) {
          debugPrint(e.toString());
        }

        return;
      }

      if (signedOut && user != null) {
        await userCRUD.onSignIn(authUid: user.id);
      }
      signedOut = user == null;

      emit(user);
    });
  }

  StreamSubscription<UserModel?>? _userStream;
  late StreamSubscription<User?> _authStream;
  bool signedOut = true;

  @override
  Future<void> close() {
    _userStream?.cancel();
    _authStream.cancel();
    return super.close();
  }

  Future<void> setBanner({required String banner}) async {
    if (state == null) return;
    if (banner == state!.banner) return;

    await userCRUD.update(
      documentId: state!.id,
      data: state!.copyWith(banner: banner),
    );
  }

  Future<void> setPhoto({required String photo}) async {
    if (state == null) return;
    if (photo == state!.photo) return;

    await userCRUD.update(
      documentId: state!.id,
      data: state!.copyWith(photo: photo),
    );
  }

  Future<void> setUsername({required String username}) async {
    if (state == null) return;
    if (username == state!.username) return;

    await userCRUD.update(
      documentId: state!.id,
      data: state!.copyWith(
        username: username,
        usernameLowercase: username.toLowerCase(),
      ),
    );
  }
}
