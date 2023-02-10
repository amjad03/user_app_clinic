



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../screens/appointment/appointment/appointments.dart';
import '../../screens/appointment/appointment/appointments_page.dart';
import '../../src/widgets/notifications.dart';

class BookAppointmentController extends GetxController {
  // static SignUpController get instance => Get.find();


  NotificationServices notificationServices = NotificationServices();

  static BookAppointmentController instance = Get.put(BookAppointmentController());

  // final email = TextEditingController();
  // final password = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirm_pass = TextEditingController();


  Future<void> bookAppointment(String name, String age, String blood, String gender, String phone, String address, String date,String time,String i,String scanAmount,String scanType,String paymentStatus,String appointmentStatus,BuildContext context) async {
    // final FirebaseAuth _auth = FirebaseAuth.instance;

    User? user = await FirebaseAuth.instance.currentUser;
    var thisUser = user?.uid.toString() as String;


    //-----------------adding data in firebase firestore for the user --------------//
    // DocumentReference<Map<String, dynamic>> usersTotalAppointments = FirebaseFirestore.instance
    //     .collection('Users Appointments')
    //     .doc(thisUser)
    //     .collection("Appointments")
    //     .doc(thisUser);
    //
    // await usersTotalAppointments.set({
    //   // "userId" : thisUser,
    //   "name": name,
    //   "age": age,
    //   "blood": blood,
    //   "gender": gender,
    //   "phone": phone,
    //   "address": address,
    //   "date" : date,
    //   "time" : time,
    //   "scanAmount" : scanAmount,
    //   "scanType" : scanType,
    //   "paymentStatus" : paymentStatus,
    //   "appointmentStatus" : appointmentStatus,
    // });

    //-----------------adding data in firebase realtime database --------------//
    final FirebaseDatabase _firestore = FirebaseDatabase.instance;

    DatabaseReference ref = await _firestore.ref('Appointments');


    // await ref.set({
    // User user = await _auth.currentUser();
    // User? user = FirebaseAuth.instance.currentUser;
    //
    // DatabaseReference ref = _firestore.ref('Appointments');

    // await ref.set({
    //   "userId" : thisUser,
    //   "name": name,
    //   "age": age,
    //   "blood": blood,
    //   "gender": gender,
    //   "phone": phone,
    //   "address": address,
    //   "date" : date,
    // }).then((result) {
    //   showSuccess(context);
    // });

    String msgNow = "Hello $name,You have successfully booked your appointment.";
    String msgShedule = "Hi $name, You have an appointment for $scanType on $date.Don't miss it Thank you";
    // int tm = DateTime.parse(time).hour;
    int tm = 27;

    await ref.child(thisUser).push().set({
      // "userId" : thisUser,
      "name": name,
      "age": age,
      "blood": blood,
      "gender": gender,
      "phone": phone,
      "address": address,
      "date" : date,
      "time" : time,
      "scanAmount" : scanAmount,
      "scanType" : scanType,
      "paymentStatus" : paymentStatus,
      "appointmentStatus" : appointmentStatus,
    }).then((result) {
      showSuccess(context);
    });

    DatabaseReference reference = FirebaseDatabase.instance.ref('Time Slots').child('27-12-2022');
    Map<String, bool> timeslotsUpdate = {
      'status': false,
    };
    reference.child(i.toString()).update(timeslotsUpdate);

    notificationServices.scheduleNotification("Clinic App", msgShedule, tm);


    //----------------------------------------------------------------------------------------------------------------------------//

    final FirebaseDatabase _firestoreForAdmin = FirebaseDatabase.instance;

    DatabaseReference refForAdmin = await _firestoreForAdmin.ref('Appointments For Admin');

    await refForAdmin.push().set({
      "userId" : thisUser,
      "name": name,
      "age": age,
      "blood": blood,
      "gender": gender,
      "phone": phone,
      "address": address,
      "date" : date,
      "time" : time,
      "scanAmount" : scanAmount,
      "scanType" : scanType,
      "paymentStatus" : paymentStatus,
      "appointmentStatus" : appointmentStatus,
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
                children: const [
                  SizedBox(height: 10,),
                  Image(
                      width: 80,
                      height: 80,
                      image: AssetImage('assets/images/booking_successful.png')
                  ),
                  SizedBox(height: 10,),
                  Text("Thank You!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  SizedBox(height: 30,),
                  Text("Your Appointment has been booked successfully.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87,height: 1.5),textAlign: TextAlign.center,)
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
                    // Navigator.popAndPushNamed(context, "/appointment_status");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TotalAppointments()));
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


