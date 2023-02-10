import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/repository/authentication_repository.dart';




class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  //Call this Function from Design & it will do the rest
  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
    if(error != null) {
      Get.showSnackbar(
          GetSnackBar(
            onTap: (snack) {
              return;
            },
            message: error.toString(),
            isDismissible: true,
            duration: const Duration(seconds: 3),
          )
      );
    }


  }
}