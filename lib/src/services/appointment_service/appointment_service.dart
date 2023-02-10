import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/database/total_appointment_model.dart';

class AppointmentService {


  // User? user = FirebaseAuth.instance.currentUser?.uid as User?;
  // var thisUser = user?.toString();
  //

  final appointmentRef = FirebaseFirestore.instance
      .collection('Users Appointments').doc(FirebaseAuth.instance.currentUser?.uid.toString()).collection("Appointments")
      // .collection('Users Appointments').doc("8ZtTDt5fK4hjcrJIlscgR7Orb7f2").collection("Appointments")
      .withConverter<TotalAppointmentModel>(
    fromFirestore: (snapshot, _) => TotalAppointmentModel.fromJson(snapshot.data()!),
    toFirestore: (data, _) => data.toJson(),
  );
      // .where("userId", isEqualTo: "sOvCWI3wqPOAVbBn1q7IszrNHyO2")
  Future<List<TotalAppointmentModel>> getAppointments() async {
    var querySnapshot = await appointmentRef.get();
    var appointmentItemList =  querySnapshot.docs.map((doc) => doc.data()).toList();
    return appointmentItemList;
  }

}