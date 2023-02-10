import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app_clinic/screens/authentication/login.dart';
import 'package:user_app_clinic/screens/authentication/register.dart';
import 'package:user_app_clinic/screens/home_screens/dashboard.dart';

import 'exceptions/login_email_password_failure.dart';
import 'exceptions/signup_email_password_failure.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();



  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const RegisterPage()) : Get.offAll(() => const DashboardPage());

  }

  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // firebaseUser.value != null ? Get.offAll(() => const DashboardPage()) : Get.to(() => const RegisterPage());
      firebaseUser.value != null ? Get.offAll(() => const LoginPage()) : Get.to(() => const RegisterPage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }


  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithEmailAndPasswordFailure.fromCode(e.code);
      return ex.message;
    } catch (_) {
      const ex = LoginWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }


  Future<void> logout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to logout?'),
          content: const Text("You have to login again in order to get into the app",textAlign: TextAlign.center,),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () async{
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
    await _auth.signOut();
  }

}