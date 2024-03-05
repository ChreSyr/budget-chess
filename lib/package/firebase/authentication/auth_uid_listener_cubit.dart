import 'dart:async';

import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthListenerCubit<T> extends Cubit<T> {
  AuthListenerCubit(super.initialState) {
    _authStreamSubscription =
        FirebaseAuth.instance.userChanges().listen((auth) {
      final newAuth = auth == null || auth.isVerified ? null : auth;
      if (newAuth == _auth) return;
      _auth = newAuth;
      authChanged(newAuth);
    });
  }

  User? _auth;
  late StreamSubscription<User?>? _authStreamSubscription;

  // Called each time the user in Firebase Authentication changed. If the user
  // is not verified yet, the value is null.
  void authChanged(User? auth);

  @override
  Future<void> close() {
    _authStreamSubscription?.cancel();
    return super.close();
  }
}

abstract class AuthUidListenerCubit<T> extends Cubit<T> {
  AuthUidListenerCubit(super.initialState) {
    _authStreamSubscription =
        FirebaseAuth.instance.userChanges().listen((auth) {
      final newAuthUid = auth == null || auth.isVerified ? null : auth.uid;
      if (newAuthUid == _authUid) return;
      _authUid = newAuthUid;
      authUidChanged(newAuthUid);
    });
  }

  String? _authUid;
  late StreamSubscription<User?>? _authStreamSubscription;

  // Called each time the user in Firebase Authentication changed. If the user
  // is not verified yet, the value is null.
  void authUidChanged(String? authUid);

  @override
  Future<void> close() {
    _authStreamSubscription?.cancel();
    return super.close();
  }
}
