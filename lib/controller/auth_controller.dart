// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grootan/controller/login_details_controller.dart';
import 'package:grootan/utils/constants.dart';
import 'package:grootan/view/plugin_page.dart';

class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  // LoginDetailsController loginDetailsController = Get.put(LoginDetailsController());

  // LoginDetailsController loginDetailsController = LoginDetailsController();
  RxString verificationCode = ''.obs;
  bool isProgress = false;

  checkPhoneDigit(context) {

    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter phone number."),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
    } else if (phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Phone number should be 10 characters."),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
    } else {

      verifyPhoneNumber();
    }
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print('user logged in verfication completed');
            }
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (verificationId, resendToken) {
          verificationCode.value = verificationId;
          print('code sent ${verificationCode.value}');
        },
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode.value = verificationId;
        });

  }

  loginUser(context) async {
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter phone number."),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
    } else if (phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Phone number should be 10 characters."),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
    } else if (otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter OTP number."),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
    } else if (otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("OTP length must be 6"),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
    } else {
      isProgress = true;
      update();
      FocusManager.instance.primaryFocus?.unfocus();

      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode.value,
              smsCode: otpController.text))
          .then((value) async {
        if (value.user != null) {
          FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;

          phoneController.clear();
          otpController.clear();
          verificationCode.value = '';
          Get.off(() => PluginPage());
          isProgress = false;
          update();

          // loginDetailsController.generateRandomNumber();

          print('user logged in');
        }
      });
    }
  }
}
