import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> _hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await _hasBiometrics();
    if (!isAvailable) {
      Fluttertoast.showToast(
          msg:
              "Sorry,Biometric unlock is not present or permission was denied");
      return false;
    }
    try {
      return await _auth.authenticate(
          localizedReason: "Please use your Biometric to Authenticate",
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true, useErrorDialogs: true),
          authMessages: []);
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Failed To use Biometric");
      return false;
    }
  }
}
