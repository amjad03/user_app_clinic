import 'package:flutter/material.dart';
import 'package:user_app_clinic/screens/appointment/cancel_appointment.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails({Key? key,
    required this.name,
    required this.age,
    required this.blood,
    required this.gender,
    required this.phone,
    required this.address,
    required this.date,
    required this.time,
    required this.scanAmount,
    required this.scanType,
    required this.paymentStatus,
    required this.appointmentStatus,
    required this.keys,
  }) : super(key: key);

  final String name;
  final String age;
  final String blood;
  final String gender;
  final String phone;
  final String address;
  final String date;
  final String time;
  final String scanAmount;
  final String scanType;
  final String paymentStatus;
  final String appointmentStatus;
  final String keys;
  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Details"),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData.fallback(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              child: widget.appointmentStatus == "complete" ? Column(
                children: const [
                  Text("Thank You",style: TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Text("You have successfully completed your appointment",style: TextStyle(color: Colors.black87,fontSize: 16,),textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Divider()
                ],
              ) : widget.appointmentStatus == "pending" ? Column(
                children: [
                  const Text("Hello...",style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("You have an appointment on ${widget.date} with details mentioned below",style: const TextStyle(height: 1.5,color: Colors.black87,fontSize: 16,),textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 10,),
                  const Divider()
                ],
              ) :
              Column(
                children: const [
                  Text("Appointment Cancelled",style: TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Text("You have Cancelled this appointment",style: TextStyle(color: Colors.black87,fontSize: 16,),textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Divider()
                ],
              ),
            ),
            titleWithName("Name", widget.name),
            titleWithName("Age", widget.age),
            titleWithName("Blood Group", widget.blood),
            titleWithName("Phone", widget.phone),
            titleWithName("Adress", widget.address),
            const SizedBox(height: 10,),
            const Divider(color: Colors.black26,),
            const SizedBox(height: 10,),
            titleWithName("Date of Appointment", widget.date),
            titleWithName("Time", widget.time),
            titleWithName("Scan Amount", "Rs:${widget.scanAmount}/-"),
            titleWithName("Payment Mode", "Pay in Clinic"),
            titleWithName("Payment Status", widget.paymentStatus),
            const SizedBox(height: 25,),
            Center(
              child: widget.appointmentStatus == "pending" ? ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.red
                  )
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CancelAppointment(keys: widget.keys,)));
                },
                child: const Text("Cancel Appointment"),
              ) : null,
            )
          ],
        ),
      ),
    );
  }
}


Widget titleWithName(String name,String title){
  return Padding(
    padding: const EdgeInsets.only(left: 30.0,top: 8,right: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$name : ",style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500)),
        const SizedBox(width: 20,),
        Text(title,style: const TextStyle(color: Colors.black,fontSize: 16),),
      ],
    ),
  );
}