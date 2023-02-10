import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/repository/authentication_repository.dart';

class SignUpController extends GetxController {
  // static SignUpController get instance => Get.find();

  static SignUpController instance = Get.put(SignUpController());

  // final email = TextEditingController();
  // final password = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirm_pass = TextEditingController();

  Future<void> registerUser(String email, String password) async {
    String? error = (await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password)) as String?;
    if (error != null) {
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
