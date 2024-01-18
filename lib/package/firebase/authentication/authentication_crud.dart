import 'dart:async';

import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/storage/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firebaseAuth = FirebaseAuth.instance;

final _googleAuth = GoogleSignIn(
  clientId:
      // ignore: lines_longer_than_80_chars
      '737365859201-spnihhusekc0prr23451hdjaj9a6dltc.apps.googleusercontent.com',
);
final _googleAuthProvider = GoogleAuthProvider();

final _facebookAuth = FacebookLogin(debug: true);
final _facebookAuthProvider = FacebookAuthProvider();

class _AuthenticationCRUD {
  final authenticationCubit = AuthenticationCubit._();
  final authProviderStatusCubit = AuthProviderStatusCubit();

  /// Permanently delete account. Reauthentication may be required.
  Future<void> deleteUserAccount({String? userId}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        final userInfo = user.providerData.first;

        authProviderStatusCubit.waiting();
        try {
          if (_googleAuthProvider.providerId == userInfo.providerId) {
            await user.reauthenticateWithProvider(_googleAuthProvider);
          } else if (_facebookAuthProvider.providerId == userInfo.providerId) {
            await user.reauthenticateWithProvider(_facebookAuthProvider);
          }
          authProviderStatusCubit.success();
        } catch (_) {
          return authProviderStatusCubit.error();
        }

        await user.delete();
      } else {
        rethrow;
      }
    }

    // Delete user in firestore. Also delete its relationships
    await userCRUD.delete(documentId: user.uid);

    // Delete user photo in firebase storage
    final photoRef = FirebaseStorage.instance.getUserPhotoRef(user.uid);
    try {
      await photoRef.delete();
    } on FirebaseException catch (e) {
      if (e.code != 'object-not-found') rethrow;
    }
  }

  /// Reload the user, to check if something changed.
  void reloadUser() {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    user.reload();
  }

  /// Send an email to verify property
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    await user.sendEmailVerification();
  }

  /// Send an email to reset the password
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  void setLanguageCode(String code) => _firebaseAuth.setLanguageCode(code);

  /// SignIn with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// SignIn with Facebook
  Future<void> signInWithFacebook() async {
    authProviderStatusCubit.waiting();

    try {
      // Log in
      final res = await _facebookAuth.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ],
      );

      // Check result status
      switch (res.status) {
        case FacebookLoginStatus.cancel:
          return authProviderStatusCubit.idle();
        case FacebookLoginStatus.error:
          return authProviderStatusCubit.error();
        case FacebookLoginStatus.success:
          final accessToken = res.accessToken;
          if (accessToken == null) {
            return authProviderStatusCubit.error();
          }

          await FirebaseAuth.instance.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token),
          );
          authProviderStatusCubit.success();
      }
    } catch (_) {
      authProviderStatusCubit.error();
    }
  }

  /// SignIn with Google
  Future<void> signInWithGoogle() async {
    authProviderStatusCubit.waiting();

    try {
      // begin interactive sign in process
      final gUser = await _googleAuth.signIn();

      if (gUser == null) {
        // Handle the case where the user canceled the sign-in
        return authProviderStatusCubit.idle();
      }

      // obtain auth details from request
      final gAuth = await gUser.authentication;

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      authProviderStatusCubit.success();
    } catch (_) {
      authProviderStatusCubit.error();
    }
  }

  /// SingOut current User
  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    // Sign out to force the account chooser next time
    await _googleAuth.signOut();
  }

  /// SignUp with email and password
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

enum AuthProviderStatus { idle, waiting, success, error }

class AuthProviderStatusCubit extends Cubit<AuthProviderStatus> {
  AuthProviderStatusCubit() : super(AuthProviderStatus.idle);

  void error() => emit(AuthProviderStatus.error);
  void idle() => emit(AuthProviderStatus.idle);
  void success() => emit(AuthProviderStatus.success);
  void waiting() => emit(AuthProviderStatus.waiting);
}

class AuthenticationCubit extends Cubit<User?> {
  AuthenticationCubit._() : super(_firebaseAuth.currentUser) {
    _authStream = _firebaseAuth.userChanges().listen(emit);
  }

  late StreamSubscription<User?> _authStream;

  @override
  Future<void> close() {
    _authStream.cancel();
    return super.close();
  }
}

extension UserIsVerified on User {
  /// true if the email is verified or has been provided by google or facebook
  bool get isVerified {
    return emailVerified ||
        providerData.where((e) => e.providerId != 'password').isNotEmpty;
  }
}

final authenticationCRUD = _AuthenticationCRUD();
