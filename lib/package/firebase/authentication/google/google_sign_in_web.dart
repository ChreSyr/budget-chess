import 'package:crea_chess/package/firebase/authentication/google/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';

final _googleWebPlugin = GoogleSignInPlatform.instance as GoogleSignInPlugin;

class GoogleSignInInterfaceWeb implements GoogleSignInInterface {
  @override
  Widget getSignInButton({required bool darkMode}) {
    return _googleWebPlugin.renderButton(
      configuration: GSIButtonConfiguration(
        locale: FirebaseAuth.instance.languageCode,
        theme: darkMode ? GSIButtonTheme.filledBlack : GSIButtonTheme.outline,
      ),
    );
  }
}

GoogleSignInInterface getInterface() => GoogleSignInInterfaceWeb();
