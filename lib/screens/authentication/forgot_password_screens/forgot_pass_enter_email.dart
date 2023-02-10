import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../../../src/widgets/text_input_field.dart';
import 'forgot_pass_enter_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valid_email = true;
  bool success = false;

  final auth = FirebaseAuth.instance;

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
                  children: [
                    const Text(
                      "Hospital Name",
                      style: TextStyle(fontSize: 36, color: Colors.teal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Forgot Your Password ?",
                      style: TextStyle(fontSize: 22,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      success ? "We have send you an email to reset your password, if you don't find it in the inbox check the spam folder" : "",
                      style: const TextStyle(fontSize: 16, color: Colors.black45),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----- Email -----//
                      // CustomTextField(title: "Email",
                      //     icon: Icons.email,
                      //     type: TextInputType.emailAddress,
                      //     password: false,
                      //     address: false),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              label: Text("Enter Your Registered email"),
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              iconColor: Colors.black45,
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black45
                                ),
                              )
                          ),
                          validator: (value) {
                            valid_email = EmailValidator.validate(value!);
                            if(valid_email){
                              return null;
                            }
                            else {
                              return "Invalid email";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: !success ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text("Back"),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordEnterOtp()));
                                if(_formKey.currentState!.validate()){
                                  auth.sendPasswordResetEmail(email: emailController.text)
                                      .then((value) {
                                    setState(() {
                                      success = true;
                                    });

                                  });
                                }

                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text("Proceed"),
                              ),
                            ),
                          ],
                        ) : ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0),
                            child: Text("OK"),
                          ),
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

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
