import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../src/widgets/SelectBox.dart';
import '../../src/widgets/widgets.dart';


class CancelAppointment extends StatefulWidget {
  CancelAppointment({Key? key,
    required this.keys
  }) : super(key: key);

  final String keys;

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  bool selected = false ;
  String? reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cancel Appointment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              const Text("Reason for Canceling Appointment :",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),textAlign: TextAlign.start,),
              const SizedBox(height: 15,),
              // SelectBox(title: "I have another appointment"),
              // SelectBox(title: "I am out of city"),
              // SelectBox(title: "I want appointment in later date"),
              // SelectBox(title: "Financial Issue"),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       selected = !selected;
              //     });
              //   },
              //     child: SelectBox(title: "Other Reasons")
              // ),
              // selected ? Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: textFieldWithoutIcon("Other Reasons", TextInputType.text, true),
              // ) :
              //     Container(),
              RadioListTile(
                title: const Text("I have another appointment"),
                value: "I have another appointment",
                // dense: true,
                groupValue: reason,
                onChanged: (value){
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("I am out of city"),
                value: "I am out of city",
                // dense: true,
                groupValue: reason,
                onChanged: (value){
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("I want appointment in later date"),
                value: "I want appointment in later date",
                // dense: true,
                groupValue: reason,
                onChanged: (value){
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("Financial Issue"),
                value: "Financial Issue",
                // dense: true,
                groupValue: reason,
                onChanged: (value){
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("Other Reason"),
                value: "other",
                // dense: true,
                groupValue: reason,
                onChanged: (value){
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              Container(
                child: reason == "other" ? TextFormField(
                  // controller: address,
                  textAlign: TextAlign.start,
                  cursorColor: Colors.grey,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      // label: Text("Enter the reason "),
                      hintText: "Enter the Reason",
                      border: OutlineInputBorder(),
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
                ) : null,
              ),
              const SizedBox(height: 25,),
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                      // backgroundColor: MaterialStatePropertyAll(
                      //     Color(0xFF0527DB)
                      // )
                  ),
                  onPressed: () async {
                    // print("clicked");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CancelAppointment()));
                    if(reason != null){
                      User? user = await FirebaseAuth.instance.currentUser;
                      var thisUser = user?.uid.toString() as String;
                      DatabaseReference ref = FirebaseDatabase.instance.ref('Appointments').child(thisUser).child(widget.keys);

                      await ref.update({
                        'appointmentStatus' : 'cancelled'
                      }).then((value) =>
                          showSuccess(context)
                      );
                    }
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showSuccess(BuildContext context) async {
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
                  Text("Cancelled!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  SizedBox(height: 30,),
                  Text("Your Appointment has been Cancelled successfully.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87,height: 1.5),textAlign: TextAlign.center,)
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
                    // Navigator.of(context).pop();
                    Navigator.popAndPushNamed(context, "/home_page");
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
