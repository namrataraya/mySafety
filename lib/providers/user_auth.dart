import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_safety/helpers/change_screen.dart';
import 'package:my_safety/screens/home_page.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class UserAuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verID = '';

  Future<void> verifyPhone(
      BuildContext context, String phoneNumber, Function setData) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          showSnackBar(context, "Verification Completed");
        },
        verificationFailed: (FirebaseAuthException authException) async {
          if (authException.code == 'invalid-phone-number') {
            print("The provided phone number is not valid.");
            showSnackBar(context, authException.toString());
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print("CODE SENT -Verification ID = $verificationId");
          verID = verificationId;
          showSnackBar(context, "Verification code sent on the phone number");
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
          // showSnackBar(context, "Time out");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInWithPhoneNumber(
    String smsCode,
    BuildContext context,
  ) async {
    AuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: smsCode);
    UserCredential result = await _auth.signInWithCredential(credential);
    result.user;
    changeScreen(context, HomePage());
    showSnackBar(context, "Logged In");
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future signOut() async {
    _auth.signOut();
    return Future.delayed(Duration.zero);
  }
}
