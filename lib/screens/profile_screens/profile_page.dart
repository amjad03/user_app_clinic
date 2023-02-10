import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app_clinic/screens/profile_screens/update_profile.dart';

import '../../constants/constants.dart';
import '../../src/repository/authentication_repository.dart';
import '../../src/theme/theme.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key,
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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isLoading = false;

  // String name1="";
  // String age1="";
  // String gender1="";
  // String blood1="";
  // String phone1="";
  // String email1="";
  // String address1="";

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController blood = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // var user_name_first_letter = name1[0];


    // var textColor = themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.white;
    // var btnColor = themeProvider.themeMode == ThemeMode.dark ? Colors.black : const Color(0xFF0527DB);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0.1)
                        ),
                        // child: Center(child: Text(Constants.user_name_first_letter,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)),
                        child: Icon(Icons.person,size: 50,color: Colors.black45,),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: Container(
                      //     width: 40,
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(50),
                      //       color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
                      //     ),
                      //     child: Icon(Icons.camera_alt,color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hi, ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500)),
                    Text(widget.name.toString(),style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              const Divider(),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: name,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Full Name"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: age,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Age"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: gender,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Gender"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: blood,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Blood"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: phone,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Phone"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: email,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Email"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,right: 11.0,top: 5.0),
              //   child: TextFormField(
              //     controller: address,
              //     decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       // label: Text("Address"),
              //       border: OutlineInputBorder(),
              //     ),
              //     enabled: false,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              //   child: Row(
              //     children: [
              //       const Text("Name : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
              //       Text(name.text.capitalize.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  children: [
                    const Text("Age : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                    Text(widget.age.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  children: [
                    const Text("Gender : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                    Text(widget.gender.toString().toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  children: [
                    const Text("Blood Group : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                    Text(widget.blood.toString().toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  children: [
                    const Text("Phone : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                    Text(widget.phone.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  children: [
                    const Text("Email : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                    Text(widget.email.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  children: [
                    const Text("Address : ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                    Text(widget.address.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              // text("Name", "User Name"),
              // text("Age", "35 Years"),
              // text("Gender", "Male"),
              // text("Blood Group", "B+ve"),
              // text("Phone", "9876543210"),
              // text("Email", "test_email@gmail.com"),
              // text("Address","Vidhya Nagar,Yellapur road "),
              // text("Password","*********"),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          // backgroundColor: MaterialStatePropertyAll(
                          //     btnColor
                          // )
                      ),
                      onPressed: () async{
                        Navigator.of(context).pop();
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile(blood: widget.blood.toString(),phone: widget.phone.toString(),name: widget.name.toString(),gender: widget.gender.toString(),age: widget.age.toString(),address: widget.address.toString(),email: widget.email.toString(),)));
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpdateProfile(blood: blood.text,phone: phone.text,name: name.text,gender: gender.text,age: age.text,address: address.text,email: email.text,)));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text("  Edit   "),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          // backgroundColor: MaterialStatePropertyAll(
                          //     btnColor
                          // )
                      ),
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CancelAppointment()));
                        AuthenticationRepository.instance.logout(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text("Logout"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ),
        Opacity(
          opacity: 0.8,
          child: isLoading ? ModalBarrier(dismissible: false, color: Colors.black) : null,
        ),
        Center(
          child: isLoading ? CircularProgressIndicator() : null,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    // name1 = UserData.getUserName() ?? '';
    // age1 = UserData.getUserAge() ?? '';
    // gender1 = UserData.getUserGender() ?? '';
    // blood1 = UserData.getUserBlood() ?? '';
    // phone1 = UserData.getUserPhone() ?? '';
    // email1 = UserData.getUserEmail() ?? '';
    // address1 = UserData.getUserAddress() ?? '';
    // print(name1.toString());
  }

  getUserData() async{

    // SharedPreferences sp = await SharedPreferences.getInstance();
    // name1 = sp.getString('name')!;
    // age1 = sp.getString('age')!;
    // gender1 = sp.getString('gender')!;
    // blood1 = sp.getString('blood')!;
    // phone1 = sp.getString('phone')!;
    // email1 = sp.getString('email')!;
    // address1 = sp.getString('address')!;
    // setState(() {
    //   isLoading = true;
    // });
    // Future<void> getData()async{
    //   User? user = await FirebaseAuth.instance.currentUser;
    //   var thisUser = user?.uid.toString() as String;
    //
    //   DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(thisUser);
    //
    //   DatabaseReference name1 = ref.child('name');
    //   DatabaseEvent event1 = await name1.once();
    //   name.text = event1.snapshot.value.toString();
    //
    //   DatabaseReference age1 = ref.child('age');
    //   DatabaseEvent event2 = await age1.once();
    //   age.text = event2.snapshot.value.toString();
    //
    //   DatabaseReference blood1 = ref.child('blood');
    //   DatabaseEvent event3 = await blood1.once();
    //   blood.text = event3.snapshot.value.toString();
    //
    //   DatabaseReference gender1 = ref.child('gender');
    //   DatabaseEvent event4 = await gender1.once();
    //   gender.text = event4.snapshot.value.toString();
    //
    //
    //   DatabaseReference phone1 = ref.child('phone');
    //   DatabaseEvent event5 = await phone1.once();
    //   phone.text = event5.snapshot.value.toString();
    //
    //   DatabaseReference email1 = ref.child('email');
    //   DatabaseEvent event6 = await email1.once();
    //   email.text = event6.snapshot.value.toString();
    //
    //   DatabaseReference address1 = ref.child('address');
    //   DatabaseEvent event7 = await address1.once();
    //   address.text = event7.snapshot.value.toString();
    //
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
    // getData();
  }
}


Widget text(String title,String name){
  return Padding(
      padding: const EdgeInsets.only(left: 11.0,right: 11,top: 11),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("$title : ",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
            Text("  $name",style: const TextStyle(fontSize: 17),),
          ],
        ),
      ),
    );
}