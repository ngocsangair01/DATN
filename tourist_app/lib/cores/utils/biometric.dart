import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Biometric {
  final LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometrics = false;
  List<BiometricType> availableBiometrics = [];

  Future<void> checkBiometrics() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
  }

  Future<void> getAvailableBiometrics() async {
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
  }

  Future<bool> authenticate() async {
    await checkBiometrics();
    await getAvailableBiometrics();
    if (canCheckBiometrics && availableBiometrics.isNotEmpty) {
      try {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        return authenticated;
      } on PlatformException catch (e) {
        print(e);

        return false;
      }
    }
    return false;
  }
}
