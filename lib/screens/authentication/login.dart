import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app_clinic/screens/authentication/register.dart';

import '../../constants/constants.dart';

import '../../controller/auth_controller/login_controller.dart';
import './forgot_password_screens/forgot_pass_enter_email.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  bool password = true;

  bool valid_email = true ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Constants.hospital_name.toString(),
                        style: const TextStyle(fontSize: 36, color: Colors.teal),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 28, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: controller.email,
                            textAlign: TextAlign.start,
                            cursorColor: Colors.grey,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                label: Text("Email"),
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
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: controller.password,
                            textAlign: TextAlign.start,
                            cursorColor: Colors.grey,
                            obscureText: password ? true : false,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                label: const Text("Password"),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      password = !password;
                                    });
                                  },
                                  child: password ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                ),
                                border: const OutlineInputBorder(),
                                iconColor: Colors.black45,
                                labelStyle: const TextStyle(color: Colors.black45),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black45
                                  ),
                                )
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                            },
                            child: const Text("Forgot Password?",style: TextStyle(color: Colors.blue,fontSize: 15),),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color(0xFF0527DB),
                            ),
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              LoginController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text("Login"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?",style: TextStyle(color: Colors.black45,fontSize: 14),),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                              },
                              child: const Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: 14),),
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
      ),
    );
  }

}
