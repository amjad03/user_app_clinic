// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'package:password_strength/password_strength.dart';
//
// import '../../constants/constants.dart';
//
// import '../../controller/auth_controller/sing_up_controller.dart';
// import 'login.dart';
//
// class PersonalInformationStore extends StatefulWidget {
//   const PersonalInformationStore({Key? key}) : super(key: key);
//
//   @override
//   State<PersonalInformationStore> createState() => _PersonalInformationStoreState();
// }
//
// class _PersonalInformationStoreState extends State<PersonalInformationStore> {
//
//   _PersonalInformationStoreState() {
//     _selectedBloodGroup = _bloodGroupList[0];
//     _selectedGender = _genderList[0];
//   }
//
//   final controller = Get.put(SignUpController());
//
//   bool valid_email = true ;
//   bool samePassword = true;
//   double strength = 0;
//   String msg = "";
//   String error_msg = "Password Not Matched";
//
//   bool password = true;
//   bool conf_password = true;
//
//   //------------- For blood Group --------------//
//   final _bloodGroupList = [
//     "Select",
//     "A+",
//     "B+",
//     "O+",
//     "AB+",
//     "A-",
//     "B-",
//     "O-",
//     "AB-",
//   ];
//   String? _selectedBloodGroup = "";
//
//   //------------- For Gender  --------------//
//   final _genderList = [
//     "_Select_",
//     "Male",
//     "Female",
//     "Others",
//   ];
//   String? _selectedGender = "";
//   IconData? icon;
//
//   TextEditingController name = TextEditingController();
//   TextEditingController age = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController address = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController confirm_pass = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 //------------- Hospital Name and title --------------//
//                 Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children:[
//                       Text(
//                         Constants.hospital_name.toString(),
//                         style: const TextStyle(fontSize: 36, color: Colors.teal),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         "Personal Information",
//                         style: TextStyle(fontSize: 28, color: Colors.black45),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Form(
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         //------------- Name --------------//
//
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: TextFormField(
//                             controller: name,
//                             textAlign: TextAlign.start,
//                             cursorColor: Colors.grey,
//                             decoration: const InputDecoration(
//                                 contentPadding: EdgeInsets.all(15),
//                                 label: Text("Full Name"),
//                                 prefixIcon: Icon(Icons.person),
//                                 border: OutlineInputBorder(),
//                                 iconColor: Colors.black45,
//                                 labelStyle: TextStyle(color: Colors.black45),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 2,
//                                       color: Colors.black45
//                                   ),
//                                 )
//                             ),
//                             validator: (value){
//                               if(value.toString().isEmpty){
//                                 return "Required";
//                               }
//                               else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ),
//
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             //------------- Age --------------//
//
//                             Expanded(
//                               child:
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: TextFormField(
//                                   controller: age,
//                                   textAlign: TextAlign.start,
//                                   cursorColor: Colors.grey,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       contentPadding: EdgeInsets.all(15),
//                                       label: Text("Age"),
//                                       prefixIcon: Icon(Icons.calendar_today),
//                                       border: OutlineInputBorder(),
//                                       iconColor: Colors.black45,
//                                       labelStyle: TextStyle(color: Colors.black45),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: 2,
//                                             color: Colors.black45
//                                         ),
//                                       )
//                                   ),
//                                   validator: (value){
//                                     if(value.toString().isEmpty){
//                                       return "Required";
//                                     }
//                                     else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             //------------- Blood Group --------------//
//
//                             Expanded(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(right: 10),
//                                   child: DropdownButtonFormField(
//                                     alignment: Alignment.center,
//                                     value: _selectedBloodGroup,
//                                     items: _bloodGroupList
//                                         .map((e) => DropdownMenuItem(
//                                       enabled: (e.isAlphabetOnly) ? false : true,
//                                       value: e,
//                                       child: Text(e),
//                                     ))
//                                         .toList(),
//                                     onChanged: (val) {
//                                       setState(() {
//                                         _selectedBloodGroup = val as String;
//                                       });
//                                     },
//                                     icon: const Icon(Icons.arrow_drop_down),
//                                     decoration: const InputDecoration(
//                                         labelText: "Blood Group",
//                                         prefixIcon: Icon(Icons.bloodtype),
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.black45)
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.black45)
//                                         ),
//                                         labelStyle: TextStyle(color: Colors.black45),
//                                         contentPadding: EdgeInsets.all(13.0)
//                                     ),
//                                   ),
//                                 )
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         //------------- Gender --------------//
//
//                         Row(
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.only(left: 10.0),
//                               child: Text("Select Gender"),
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(top: 8,right: 10,bottom: 8),
//                                   child: DropdownButtonFormField(
//                                     alignment: Alignment.center,
//                                     value: _selectedGender,
//                                     items: _genderList
//                                         .map((e) => DropdownMenuItem(
//                                       enabled: (e.isAlphabetOnly) ? true : false,
//                                       value: e,
//                                       child: Text(e),
//                                     ))
//                                         .toList(),
//                                     onChanged: (v) {
//                                       setState(() {
//                                         _selectedGender = v as String;
//                                         if (_selectedGender == "Male") {
//                                           icon = Icons.male;
//                                         } else if (_selectedGender == "Female") {
//                                           icon = Icons.female;
//                                         } else if (_selectedGender == "Others") {
//                                           icon = Icons.transgender;
//                                         }
//                                       }
//                                       );
//                                     },
//                                     icon: const Icon(Icons.arrow_drop_down),
//                                     decoration: InputDecoration(
//                                         labelText: "Gender",
//                                         prefixIcon: Icon(icon),
//                                         border: const OutlineInputBorder(
//                                             borderSide:
//                                             BorderSide(color: Colors.black45)),
//                                         focusedBorder: const OutlineInputBorder(
//                                             borderSide:
//                                             BorderSide(color: Colors.black45)),
//                                         labelStyle:
//                                         const TextStyle(color: Colors.black45),
//                                         contentPadding: const EdgeInsets.all(13.0)),
//                                   ),
//                                 )
//                             ),
//                           ],
//                         ),
//
//                         //------------- Phone Number --------------//
//
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: TextFormField(
//                             controller: phone,
//                             textAlign: TextAlign.start,
//                             cursorColor: Colors.grey,
//                             keyboardType: TextInputType.number,
//                             decoration: const InputDecoration(
//                                 contentPadding: EdgeInsets.all(15),
//                                 label: Text("Phone Number"),
//                                 prefixIcon: Icon(Icons.call),
//                                 border: OutlineInputBorder(),
//                                 iconColor: Colors.black45,
//                                 labelStyle: TextStyle(color: Colors.black45),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 2,
//                                       color: Colors.black45
//                                   ),
//                                 )
//                             ),
//                             validator: (value){
//                               if(value.toString().isEmpty){
//                                 return "Required";
//                               }
//                               else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ),
//
//                         //------------- Address --------------//
//
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: TextFormField(
//                             controller: address,
//                             textAlign: TextAlign.start,
//                             cursorColor: Colors.grey,
//                             maxLines: 4,
//                             keyboardType: TextInputType.text,
//                             decoration: const InputDecoration(
//                                 contentPadding: EdgeInsets.all(15),
//                                 label: Text("Address"),
//                                 // hintText: "Address",
//                                 prefixIcon: Icon(Icons.house),
//                                 border: OutlineInputBorder(),
//                                 iconColor: Colors.black45,
//                                 labelStyle: TextStyle(color: Colors.black45),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 2,
//                                       color: Colors.black45
//                                   ),
//                                 )
//                             ),
//                             validator: (value){
//                               if(value.toString().isEmpty){
//                                 return "Required";
//                               }
//                               else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         //------------- Submit info Button --------------//
//                         SizedBox(
//                           child: ElevatedButton(
//                             style: const ButtonStyle(
//                               backgroundColor: MaterialStatePropertyAll(
//                                 Color(0xFF0527DB),
//                               ),
//                             ),
//                             onPressed: () async {
//                               // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
//                               if(_formKey.currentState!.validate()) {
//                                 // await SignUpController.instance.registerUser(
//                                 //     controller.email.text.trim(),
//                                 //     controller.pass.text.trim());
//                                 addUserData();
//
//                               }
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 15.0),
//                               child: Text("Submit Information"),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         )
//                       ],
//                     )
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> addUserData () async {
//     final FirebaseDatabase _firestore = FirebaseDatabase.instance;
//
//     // User user = await _auth.currentUser();
//     User? user = FirebaseAuth.instance.currentUser;
//
//     var thisUser = user?.uid.toString() as String;
//     // print(thisUser);
//     // DatabaseReference ref = _firestore.ref('Users').child(user.toString());
//
//     DatabaseReference ref = _firestore.ref('Users').child(thisUser);
//     ref.set({
//       "name": name.text,
//       "age": age.text,
//       "blood": _selectedBloodGroup.toString(),
//       "gender": _selectedGender.toString(),
//       "phone": phone.text,
//       "address": address.text
//     });
//   }
// }
//
