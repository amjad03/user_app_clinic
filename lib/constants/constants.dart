
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';



class Constants {

  //---------------------- Doctor info--------------------------//

  static String hospital_name = "Mr Doctors Clinic";
  static String doctor_name = "Mr Doctor";
  static String doctor_stream = "Scanning Specialist";
  static String doctor_available = "Now Available";
  static String doctor_unavailable = "Now Unavailable";
  static String experience = "Scanning";
  static String doctor_experience = "10+ years of experience in\n $experience";

  // static String hospital_name = FirebaseDatabase.instance.ref().child('Clinic Info/clinic_name').get() as String;
  // static String doctor_name = FirebaseDatabase.instance.ref().child('Clinic Info/doctor_name').get() as String;
  // static String doctor_stream = FirebaseDatabase.instance.ref().child('Clinic Info/stream').get() as String;
  // static String doctor_available = "Now Available";
  // static String doctor_unavailable = "Now Unavailable";
  // static String experience = FirebaseDatabase.instance.ref().child('Clinic Info/experience').get() as String;
  // static String doctor_experience = "10+ years of experience in\n $experience";

  late String hospital_name1,doctor_name1,doctor_stream1,experience1,doctor_experience1;

  Future<void> getData() async {
    hospital_name1 = FirebaseDatabase.instance.ref().child('Clinic Info/clinic_name').get() as String;
    doctor_name1 = FirebaseDatabase.instance.ref().child('Clinic Info/doctor_name').get() as String;
    doctor_stream1 = FirebaseDatabase.instance.ref().child('Clinic Info/stream').get() as String;
    experience1 = FirebaseDatabase.instance.ref().child('Clinic Info/experience').get() as String;
    doctor_experience1 = "10+ years of experience in\n $experience";

    hospital_name = hospital_name1;
    doctor_name = doctor_name1;
    doctor_stream = doctor_stream1;
    experience = experience1;
    doctor_experience = doctor_experience1;
  }


  //---------------------- Clinic info--------------------------//

  static String number = FirebaseDatabase.instance.ref().child('Clinic Info/contact_number').get() as String;
  static String clinic_number = 'tel:$number';
  // static double map_lattitude = 14.632598196453523;
  static double map_lattitude = 14.632556673039605;
  // static double map_longitude = 74.84669784272853;
  static double map_longitude = 74.84684804643253;

  //---------------------- User info--------------------------//
  static String user_name = "User Name";
  static String user_email = "user_email@gamil.com";
  static String user_name_first_letter = user_name[0];


 //-------------------------appbee--------------------//
  static String footer = "@appbee";
}


class ConstData extends StatefulWidget {
  const ConstData({Key? key}) : super(key: key);

  @override
  State<ConstData> createState() => _ConstDataState();
}

class _ConstDataState extends State<ConstData> {

  static String hospital_name = "";
  static String doctor_name = "";
  static String doctor_stream = "";
  static String experience = "";
  static String doctor_experience = "10+ years of experience in\n $experience";

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  late String hospital_name1,doctor_name1,doctor_stream1,experience1,doctor_experience1;

  @override
  void initState() {
    hospital_name1 = FirebaseDatabase.instance.ref().child('Clinic Info/clinic_name').get() as String;
    doctor_name1 = FirebaseDatabase.instance.ref().child('Clinic Info/doctor_name').get() as String;
    doctor_stream1 = FirebaseDatabase.instance.ref().child('Clinic Info/stream').get() as String;
    experience1 = FirebaseDatabase.instance.ref().child('Clinic Info/experience').get() as String;
    doctor_experience1 = "10+ years of experience in\n $experience";

    hospital_name = hospital_name1;
    doctor_name = doctor_name1;
    doctor_stream = doctor_stream1;
    experience = experience1;
    doctor_experience = doctor_experience1;
  }

  // static String hospital_name1 = FirebaseDatabase.instance.ref().child('Clinic Info/clinic_name').get() as String;
  // static String doctor_name1 = FirebaseDatabase.instance.ref().child('Clinic Info/doctor_name').get() as String;
  // static String doctor_stream1 = FirebaseDatabase.instance.ref().child('Clinic Info/stream').get() as String;
  // static String experience1 = FirebaseDatabase.instance.ref().child('Clinic Info/experience').get() as String;
  // static String doctor_experience1 = "10+ years of experience in\n $experience";

  // setState(VoidCallback fn) {
  //   hospital_name = hospital_name1;
  //   doctor_name = doctor_name1;
  //   doctor_stream = doctor_stream1;
  //   experience = experience1;
  //   doctor_experience = doctor_experience1;
  //
  // }
}


// class Constants extends StatelessWidget{
//   // const Constants({Key? key}) : super(key: key);
//
//   late String doctor,name,experience,stream;
//   static String? hospital_name;
//   static String? doctor_name;
//   static String? doctor_stream;
//   static String? doctor_available;
//   static String? doctor_unavailable;
//   static String? doctor_experience;
//
//
//   //---------------------- Clinic info--------------------------//
//   static String clinic_number = 'tel:9986458809';
//   static double map_lattitude = 14.632598196453523;
//   static double map_longitude = 74.84669784272853;
//
//   //---------------------- User info--------------------------//
//   static String user_name = "User Name";
//   static String user_email = "user_email@gamil.com";
//   static String user_name_first_letter = user_name[0];
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     // var doctor_name,experience,clinic_name,field,stream;
//
//     FirebaseFirestore.instance
//         .collection('clinic_data')
//         .doc('Clinic Name')
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       doctor = documentSnapshot.get('doctor name').toString();
//       experience = documentSnapshot.get('doctor name');
//       name = documentSnapshot.get('doctor name');
//             // field = documentSnapshot.get('doctor name');
//       stream = documentSnapshot.get('doctor name');
//
//     });
//
//     hospital_name = name;
//     doctor_name = doctor;
//     doctor_stream = stream;
//     doctor_available = "Now Available";
//     doctor_unavailable = "Now Unavailable";
//     doctor_experience = "10+ years of experience in\n$experience";
//
//     return Container();
//   }
// }





