import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'firestore_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreService = FirestoreService();

  Future<void> verifyPhoneNumber(BuildContext context, String phoneNumber,
      int timeoutDuration, void Function(String) setData) async {
    if (!kIsWeb) {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed:
              (FirebaseAuthException firebaseAuthException) async {
            debugPrint("Verification Failed: ${firebaseAuthException.message}");

            final String dateTime =
                DateTime.now().millisecondsSinceEpoch.toString();
            FirebaseFirestore.instance.collection('logs').doc(dateTime).set(
              {"message": firebaseAuthException.message},
              SetOptions(merge: false),
            );
          },
          codeSent: (String verificationId, int? _) async {
            setData(verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            debugPrint("Verification: Timeout $verificationId");
          },
          timeout: Duration(seconds: timeoutDuration),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      try {
        final ConfirmationResult confirmationResult =
            await _auth.signInWithPhoneNumber(phoneNumber);

        setData(confirmationResult.verificationId);
      } catch (firebaseAuthException) {
        debugPrint(
            'Failed SignInWithPhoneNumber: ${(firebaseAuthException as FirebaseAuthException).message}');
      }
    }
  }

  Future<void> signInWithPhoneNumber(
    BuildContext context,
    String smsCodeId,
    String otpNumber,
    void Function() setProfileCallback,
  ) async {
    try {
      final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: otpNumber,
      );
      final UserCredential phoneUserCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (phoneUserCredential.user != null) {
        if (await _firestoreService
            .hasProfileData(phoneUserCredential.user!.uid)) {
          setProfileCallback();
        } else {
          final int rn = Random().nextInt(100000000);
          try {
            await _firestoreService.uploadProfileData(
              phoneUserCredential.user!.uid,
              DateTime.now().millisecondsSinceEpoch.toString(),
              'User$rn',
              phoneUserCredential.user!.phoneNumber,
              'assets/images/profile_screen/user_profile/${rn % 20}.png',
              'assets/images/profile_screen/dummy_background.png',
            );
            await _firestoreService.uploadProfilePrivacyData(
              phoneUserCredential.user!.uid,
            );
            setProfileCallback();
          } catch (e) {
            debugPrint(
                'Push Data to Firestore with Phone SignIn: ${e.toString()}');
          }
        }
      } else {
        debugPrint('Can\'t logged in user.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
