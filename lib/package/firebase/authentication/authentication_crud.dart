import 'dart:async';

import 'package:crea_chess/package/firebase/authentication/google/google_sign_in.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firebaseAuth = FirebaseAuth.instance;

final _googleAuth = GoogleSignIn();
final _googleAuthProvider = GoogleAuthProvider();

final _facebookAuth = FacebookLogin(debug: true);
final _facebookAuthProvider = FacebookAuthProvider();

const accountBeingDeleted = '#---account-being-deleted---#';

class _AuthenticationCRUD {
  final authProviderStatusCubit = AuthProviderStatusCubit();

  /// Permanently delete account. Reauthentication may be required.
  Future<void> deleteUserAccount({String? userId}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    try {
      /// This prevents the UserCubit to create a new UserModel in Firestore
      /// after the current UserModel will be deleted
      await user.updateDisplayName(accountBeingDeleted);

      // Delete user.
      await userCRUD.delete(documentId: user.uid);

      // Delete relationships of user.
      await relationshipCRUD.onAccountDeletion(userId: user.uid);

      // Delete challenges created by user.
      await challengeCRUD.onAccountDeletion(userId: user.uid);

      // Delete user photo in firebase storage
      final photoRef = FirebaseStorage.instance.getUserPhotoRef(user.uid);
      try {
        await photoRef.delete();
      } on FirebaseException catch (e) {
        if (e.code != 'object-not-found') rethrow;
      }
    } catch (_) {}

    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
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

    await signOut();
  }

  Widget getGoogleSignInButton({required bool darkMode}) {
    if (!kIsWeb) return const SizedBox.shrink();
    return GoogleSignInInterface().getSignInButton(darkMode: darkMode);
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
    try {
      if (kIsWeb) {
        // Request by default the email and the public profile
        final result = await FacebookAuth.instance.login();
        if (result.status == LoginStatus.success) {
          final accessToken = result.accessToken;
          if (accessToken == null) {
            return authProviderStatusCubit.error();
          }

          await FirebaseAuth.instance.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token),
          );
          authProviderStatusCubit.success();
        } else {
          authProviderStatusCubit.error();
        }
      } else {
        authProviderStatusCubit.waiting();

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
      }
    } catch (_) {
      authProviderStatusCubit.error();
    }
  }

  /// SignIn with Google, deprecated on web
  Future<void> signInWithGoogle() async {
    authProviderStatusCubit.waiting();
        
    try {
      await _signInWithGoogleUser(await _googleAuth.signIn());
    } catch (e) {
      if (e.toString() == 'popup_closed') {
        authProviderStatusCubit.idle();
      } else {
        authProviderStatusCubit.error();
      }
    }
  }

  Future<void> _signInWithGoogleUser(GoogleSignInAccount? gUser) async {
    if (gUser == null) {
      // Handle the cases where the user canceled the sign-in or signed out
      return authProviderStatusCubit.idle();
    }
    authProviderStatusCubit.waiting();

    try {
      // obtain auth details from request
      final gAuth = await gUser.authentication;

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      authProviderStatusCubit.success();
    } catch (e) {
      authProviderStatusCubit.error();
    }
  }

  /// SingOut current User
  Future<void> signOut() async {
    // Modify isConnected.
    await userCRUD.onSignOut(authUid: _firebaseAuth.currentUser?.uid);

    // Sign out
    await _firebaseAuth.signOut();

    // Sign out to force the account chooser next time
    await _googleAuth.signOut();

    // Facebook
    await FacebookAuth.instance.logOut();
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
  AuthenticationCubit() : super(_firebaseAuth.currentUser) {
    _authStream = _firebaseAuth.userChanges().listen(emit);
    if (kIsWeb) {
      _googleAuth.onCurrentUserChanged
          .listen(authenticationCRUD._signInWithGoogleUser);
      FacebookAuth.i.webAndDesktopInitialize(
        appId: '880565243648285',
        cookie: true,
        xfbml: true,
        version: 'v15.0',
      );
    }
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
