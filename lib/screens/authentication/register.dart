import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:password_strength/password_strength.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../constants/constants.dart';

import '../../controller/auth_controller/sing_up_controller.dart';
import '../../src/theme/theme.dart';
import '../../src/utils/user_data.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  _RegisterPageState() {
    _selectedBloodGroup = _bloodGroupList[0];
    _selectedGender = _genderList[0];
  }

  final controller = Get.put(SignUpController());

  bool valid_email = true ;
  bool samePassword = true;
  double strength = 0;
  String msg = "";
  String error_msg = "Password Not Matched";

  bool password = true;
  bool conf_password = true;

  //------------- For blood Group --------------//
  final _bloodGroupList = [
    "Select",
    "A+",
    "B+",
    "O+",
    "AB+",
    "A-",
    "B-",
    "O-",
    "AB-",
  ];
  String? _selectedBloodGroup = "";

  //------------- For Gender  --------------//
  final _genderList = [
    "_Select_",
    "Male",
    "Female",
    "Others",
  ];
  String? _selectedGender = "";
  IconData? icon;

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirm_pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    var textColor = themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.white;
    var btnColor = themeProvider.themeMode == ThemeMode.dark ? Colors.black : const Color(0xFF0527DB);

    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //------------- Hospital Name and title --------------//
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text(
                        Constants.hospital_name.toString(),
                        style: const TextStyle(fontSize: 36, color: Colors.teal),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Register",
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
                    //------------- Name --------------//

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: name,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            label: Text("Full Name"),
                            prefixIcon: Icon(Icons.person),
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
                        validator: (value){
                          if(value.toString().isEmpty){
                            return "Required";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //------------- Age --------------//

                        Expanded(
                          child:
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: age,
                              textAlign: TextAlign.start,
                              cursorColor: Colors.grey,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  label: Text("Age"),
                                  prefixIcon: Icon(Icons.calendar_today),
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
                              validator: (value){
                                if(value.toString().isEmpty){
                                  return "Required";
                                }
                                else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        //------------- Blood Group --------------//

                        Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: DropdownButtonFormField(
                                alignment: Alignment.center,
                                value: _selectedBloodGroup,
                                items: _bloodGroupList
                                    .map((e) => DropdownMenuItem(
                                          enabled: (e.isAlphabetOnly) ? false : true,
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedBloodGroup = val as String;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                decoration: const InputDecoration(
                                  labelText: "Blood Group",
                                  prefixIcon: Icon(Icons.bloodtype),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45)
                                  ),
                                  labelStyle: TextStyle(color: Colors.black45),
                                  contentPadding: EdgeInsets.all(13.0)
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //------------- Gender --------------//

                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text("Select Gender"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 8,right: 10,bottom: 8),
                              child: DropdownButtonFormField(
                                alignment: Alignment.center,
                                value: _selectedGender,
                                items: _genderList
                                    .map((e) => DropdownMenuItem(
                                          enabled: (e.isAlphabetOnly) ? true : false,
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                    setState(() {
                                      _selectedGender = v as String;
                                      if (_selectedGender == "Male") {
                                        icon = Icons.male;
                                      } else if (_selectedGender == "Female") {
                                        icon = Icons.female;
                                      } else if (_selectedGender == "Others") {
                                        icon = Icons.transgender;
                                      }
                                    }
                                  );
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                decoration: InputDecoration(
                                labelText: "Gender",
                                prefixIcon: Icon(icon),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45)),
                                labelStyle:
                                    const TextStyle(color: Colors.black45),
                                contentPadding: const EdgeInsets.all(13.0)),
                          ),
                        )
                        ),
                      ],
                    ),

                    //------------- Email --------------//

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: controller.email,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.emailAddress,
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

                    //------------- Phone Number --------------//

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: phone,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            label: Text("Phone Number"),
                            prefixIcon: Icon(Icons.call),
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
                        validator: (value){
                          if(value.toString().isEmpty){
                            return "Required";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),

                    //------------- Address --------------//

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: address,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            label: Text("Address"),
                            // hintText: "Address",
                            prefixIcon: Icon(Icons.house),
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
                        validator: (value){
                          if(value.toString().isEmpty){
                            return "Required";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),

                    //------------- Password --------------//


                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: controller.pass,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.visiblePassword,
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
                        validator: (value) {
                          strength = estimatePasswordStrength(value!);
                          if(strength < 0.3){
                            return "Password is Too Weak";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),

                    //------------- Confirm Password --------------//

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: controller.confirm_pass,
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: conf_password ? true : false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            label: const Text("Confirm Password"),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  conf_password = !conf_password;
                                });
                              },
                              child: conf_password ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
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
                        validator: (value) {
                          if(value == controller.pass.text){
                            return null;
                            // return "Password not matched";
                          }
                          else {
                            // return null;
                            return "Password not matched";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //------------- Sign up Button --------------//
                    SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            // Color(0xFF0527DB),
                            btnColor
                          ),
                        ),
                        onPressed: () async {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                          if(_formKey.currentState!.validate()) {
                            await SignUpController.instance.registerUser(
                                controller.email.text.trim(),
                                controller.pass.text.trim());
                            addUserData();

                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.setString('name', name.text);
                            sp.setString('age', age.text);
                            sp.setString('gender', _selectedGender.toString());
                            sp.setString('blood', _selectedBloodGroup.toString());
                            sp.setString('phone', phone.text);
                            sp.setString('email', controller.email.text);
                            sp.setString('address', address.text);

                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text("Sign Up",style: TextStyle(color: textColor),),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //------------- Already have an account --------------//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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

  Future<void> addUserData () async{
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseDatabase _firestore = FirebaseDatabase.instance;

    // User user = await _auth.currentUser();
    User? user = await FirebaseAuth.instance.currentUser;
    var thisUser = user?.uid.toString() as String;

    DatabaseReference ref = await _firestore.ref('Users').child(thisUser);

    await ref.set({
      "name": name.text,
      "age": age.text,
      "blood": _selectedBloodGroup.toString(),
      "gender": _selectedGender.toString(),
      "email": controller.email.text,
      "phone": phone.text,
      "address": address.text
    });

    // UserData.setUserName(name.text);
    // UserData.setUserAge(age.text);
    // UserData.setUserBlood(_selectedBloodGroup.toString());
    // UserData.setUserGender(_selectedGender.toString());
    // UserData.setUserEmail(controller.email.text);
    // UserData.setUserPhone(phone.text);
    // UserData.setUserAddress(address.text);

  }
}

