import 'package:crea_chess/package/firebase/authentication/google/google_sign_in_stub.dart'
    if (dart.library.html) 'google_sign_in_web.dart';
import 'package:flutter/material.dart';

abstract class GoogleSignInInterface {
  factory GoogleSignInInterface() => getInterface();

  Widget getSignInButton({required bool darkMode});
}
