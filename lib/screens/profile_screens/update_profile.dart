import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app_clinic/screens/profile_screens/profile_page.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key,
    required this.name,
    required this.age,
    required this.gender,
    required this.blood,
    required this.phone,
    required this.email,
    required this.address
  }) : super(key: key);

  String name;
  String age;
  String gender;
  String blood;
  String phone;
  String email;
  String address;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  _UpdateProfileState() {
    _selectedBloodGroup = _bloodGroupList[0];
    _selectedGender = _genderList[0];
  }

  var gender,blood;

  //------------- For blood Group --------------//
  final _bloodGroupList = [
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
    "Male",
    "Female",
    "Others",
  ];
  String? _selectedGender = "";
  IconData? iconGender;
  IconData? iconBlood;

  TextEditingController name1 = TextEditingController();
  TextEditingController age1 = TextEditingController();
  TextEditingController gender1 = TextEditingController();
  TextEditingController blood1 = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController address1 = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    name1.text = widget.name;
    age1.text = widget.age;
    gender1.text = widget.gender;
    blood1.text = widget.blood;
    phone1.text = widget.phone;
    email1.text = widget.email;
    address1.text = widget.address;
    // blood = _selectedBloodGroup?.indexOf(blood1.text);
    // gender = _selectedGender?.indexOf(gender1.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: name1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text("Full Name"),
                      border: OutlineInputBorder(),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: age1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text("Age"),
                      border: OutlineInputBorder(),
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
                Container(
                  // margin: const EdgeInsets.only(top: 8,right: 10,bottom: 8),
                  padding: const EdgeInsets.all(12.0),
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
                          iconGender = Icons.male;
                        } else if (_selectedGender == "Female") {
                          iconGender = Icons.female;
                        } else if (_selectedGender == "Others") {
                          iconGender = Icons.transgender;
                        }
                      }
                      );
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(
                        labelText: "Gender",
                        prefixIcon: Icon(iconGender),
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
                ),
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: TextFormField(
                //     controller: gender1,
                //     decoration: const InputDecoration(
                //       contentPadding: EdgeInsets.all(15),
                //       label: Text("Gender"),
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                Container(
                  // margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(12.0),
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
                ),
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: TextFormField(
                //     controller: blood1,
                //     decoration: const InputDecoration(
                //       contentPadding: EdgeInsets.all(15),
                //       label: Text("Blood"),
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: phone1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text("Phone"),
                      border: OutlineInputBorder(),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: email1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text("Email"),
                      border: OutlineInputBorder(),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: address1,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text("Address"),
                      border: OutlineInputBorder(),
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
                ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        // Navigator.of(context).pop();
                        User? user = await FirebaseAuth.instance.currentUser;
                        var thisUser = user?.uid.toString() as String;

                        DatabaseReference ref = FirebaseDatabase.instance.ref('Users').child(
                            thisUser);

                        await ref.update({
                          "name": name1.text,
                          "age": age1.text,
                          "blood": _selectedBloodGroup.toString(),
                          "gender": _selectedGender.toString(),
                          "email": email1.text,
                          "phone": phone1.text,
                          "address": address1.text
                        }).then((value) =>
                            success(),
                        ).then((value) =>
                            Navigator.pop(context)
                        );

                        SharedPreferences sp = await SharedPreferences.getInstance();
                        sp.setString('name', name1.text);
                        sp.setString('age', age1.text);
                        sp.setString('gender', _selectedGender.toString());
                        sp.setString('blood', _selectedBloodGroup.toString());
                        sp.setString('phone', phone1.text);
                        sp.setString('email', email1.text);
                        sp.setString('address', address1.text);
                      }
                    },
                    child: const Text("Update Profile"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> success() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('Confirm Booking!'),
          content: Wrap(
            children: [
              Column(
                children: const [
                  SizedBox(height: 10,),
                  Image(
                      width: 80,
                      height: 80,
                      image: AssetImage('assets/images/booking_successful.png')
                  ),
                  SizedBox(height: 10,),
                  Text("Success!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  SizedBox(height: 30,),
                  Text("Your profile has been successfully updated.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87,height: 1.5),textAlign: TextAlign.center,)
                ],
              )
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),

              ],
            ),
          ],
        );
      },
    );
  }
}
