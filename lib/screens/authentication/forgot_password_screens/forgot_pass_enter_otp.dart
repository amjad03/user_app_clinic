import 'package:flutter/material.dart';
import '../../../src/widgets/text_input_field.dart';

import 'forgot_pass_new_password.dart';

class ForgotPasswordEnterOtp extends StatefulWidget {
  const ForgotPasswordEnterOtp({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEnterOtp> createState() => _ForgotPasswordEnterOtpState();
}

class _ForgotPasswordEnterOtpState extends State<ForgotPasswordEnterOtp> {
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
                      "We have Send You an OTP to 91xxxxxx16 please enter below",
                      style: TextStyle(fontSize: 18, color: Colors.black45,),
                    ),
                  ],
                ),
              ),
              Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----- Email -----//
                      CustomTextField(title: "Enter OTP",
                          icon: Icons.email,
                          type: TextInputType.emailAddress,
                          password: false,
                          address: false),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Did not recieved OTP?",style: TextStyle(color: Colors.black45,fontSize: 14),),
                          TextButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                            },
                            child: const Text("Resend",style: TextStyle(color: Colors.blue,fontSize: 14),),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordEnterNewPassword()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0),
                            child: Text("Proceed"),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not Your Number?",style: TextStyle(color: Colors.black45,fontSize: 14),),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Go Back",style: TextStyle(color: Colors.blue,fontSize: 14),),
                          )
                        ],
                      )
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
