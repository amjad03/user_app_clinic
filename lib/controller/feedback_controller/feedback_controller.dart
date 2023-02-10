import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FeedbackController extends GetxController{


  static FeedbackController instance = Get.put(FeedbackController());

  Future<void> sendFeedback(String name, String email, String feedback,BuildContext context) async {
    // final FirebaseAuth _auth = FirebaseAuth.instance;

    User? user = await FirebaseAuth.instance.currentUser;
    var thisUser = user?.uid.toString() as String;

    //-----------------adding data in firebase realtime database --------------//
    final FirebaseDatabase _firestore = FirebaseDatabase.instance;

    DatabaseReference ref = await _firestore.ref('Feedback');


    await ref.child(thisUser).push().set({
      // "userId" : thisUser,
      "name": name,
      "email" : email,
      "feedback" : feedback
    }).then((result) {
      showSuccess(context);
    });
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
                children: [
                  const SizedBox(height: 10,),
                  const Image(
                      width: 80,
                      height: 80,
                      image: AssetImage('assets/images/booking_successful.png')
                  ),
                  const SizedBox(height: 10,),
                  const Text("Thank You!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  const SizedBox(height: 30,),
                  Text(("We have received your feedback....").capitalize.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87,height: 1.5),textAlign: TextAlign.center,)
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