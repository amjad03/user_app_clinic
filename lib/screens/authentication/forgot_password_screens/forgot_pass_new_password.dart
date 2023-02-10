import 'package:flutter/material.dart';
import '../../../src/widgets/text_input_field.dart';

import '../login.dart';


class ForgotPasswordEnterNewPassword extends StatefulWidget {
  const ForgotPasswordEnterNewPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEnterNewPassword> createState() => _ForgotPasswordEnterNewPasswordState();
}

class _ForgotPasswordEnterNewPasswordState extends State<ForgotPasswordEnterNewPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Hospital Name",
                      style: TextStyle(fontSize: 36, color: Colors.teal),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Enter new Password",
                      style: TextStyle(fontSize: 28, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----- Email -----//
                      CustomTextField(title: "Password",
                          icon: Icons.lock,
                          type: TextInputType.visiblePassword,
                          password: true,
                          address: false),
                      CustomTextField(title: "Confirm Password",
                          icon: Icons.lock,
                          type: TextInputType.visiblePassword,
                          password: true,
                          address: false),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0527DB),
                                ),
                                  // shape: MaterialStatePropertyAll(
                                  //     RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(50)
                                  //     )
                                  // )
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text("Cancel"),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0527DB),
                                ),
                                  // shape: MaterialStatePropertyAll(
                                  //     RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(50)
                                  //     )
                                  // )
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text("Finish"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}