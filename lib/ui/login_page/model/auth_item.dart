import 'package:flutter/material.dart';

class AuthItem {
  final String label;
  final String assetImage;
  final Function onTap;

  static String path = 'assets/icon/auth_icon/';

  AuthItem._(this.label, this.assetImage, this.onTap);

  static final AuthItem _email = AuthItem._(
    'Continue with Email',
    path + 'email_icon.png',
    () {
      debugPrint("Login with Email");
    },
  );
  static final AuthItem _apple = AuthItem._(
    'Continue with Apple',
    path + 'apple_icon.png',
    () {
      debugPrint("Login with Apple");
    },
  );
  static final AuthItem _google = AuthItem._(
    'Continue with Google',
    path + 'google_icon.png',
    () {
      debugPrint("Login with Google");
    },
  );

  static final AuthItem _facebook = AuthItem._(
    'Continue with Facebook',
    path + 'fb_icon.png',
    () {
      debugPrint("Login with Facebook");
    },
  );

  static List<AuthItem> items = [_email, _apple, _google, _facebook];
}
