import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appointment_detail.dart';

var total;
int complete = 0,
    incomplete = 0;

class TotalAppointments extends StatefulWidget {
  const TotalAppointments({Key? key}) : super(key: key);

  @override
  State<TotalAppointments> createState() => _TotalAppointmentsState();
}

class _TotalAppointmentsState extends State<TotalAppointments> {

  static String? thisUser = FirebaseAuth.instance.currentUser?.uid.toString();
  bool isLoading = true;
  // late Query dbRef;
  // late DatabaseReference reference;

  // Future<void> getUser() async {
  //   User? user = await FirebaseAuth.instance.currentUser;
  //   thisUser = user?.uid.toString() as String;
  //   print(thisUser);
  //   // dbRef = FirebaseDatabase.instance.ref('Appointments').child(thisUser);
  //   // reference = FirebaseDatabase.instance.ref('Appointments').child(thisUser);
  // }

  // String user = '';


  // @override
  // void initState() {
  //   super.initState();
  //   getUser();
  // }

  // @override
  // void dispose() {
  //   // super.dispose();
  //   // setState(() {
  //     complete = 0;
  //     incomplete = 0;
  //     total = 0;
  //   // });
  // }

  Query dbRef = FirebaseDatabase.instance.ref('Appointments').child(thisUser.toString());
  DatabaseReference reference = FirebaseDatabase.instance.ref('Appointments').child(thisUser.toString());


  Widget listItem({required Map totalAppointments,required int i}) {
    int index = i + 1;
    return GestureDetector(
        onTap: () {
          // print(totalAppointments['key'].toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetails(
            keys: totalAppointments['key'],
            address: totalAppointments['name'],
            age: totalAppointments['age'],
            appointmentStatus: totalAppointments['appointmentStatus'],
            blood: totalAppointments['blood'],
            date: totalAppointments['date'],
            gender: totalAppointments['gender'],
            name: totalAppointments['name'],
            paymentStatus: totalAppointments['paymentStatus'],
            phone: totalAppointments['phone'],
            scanAmount: totalAppointments['scanAmount'],
            scanType: totalAppointments['scanType'],
            time: totalAppointments['time'],
          )));

        },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(index.toString(),style: TextStyle(color: Colors.grey.shade700,fontSize: 20,fontWeight: FontWeight.w600),)),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only( right: 20, top: 20),
                // width: 500,
                // height: 200,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/clinic_bg.png'),
                    fit: BoxFit.cover
                  ),
                    borderRadius: BorderRadius.circular(12),
                    // color: totalAppointments['appointmentStatus'] == "complete" ? Colors.green
                    //     : totalAppointments['appointmentStatus'] == "cancelled" ?  Colors.red
                    //     : Colors.blue,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Patient Name : ", style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(totalAppointments['name'], style: const TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .w400),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text("Date : ", style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(totalAppointments['date'], style: const TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .w400),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text("Status : ", style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(totalAppointments['appointmentStatus'],
                            style: TextStyle(
                                color: totalAppointments['appointmentStatus'] == "complete" ? Colors.green
                                    : totalAppointments['appointmentStatus'] == "cancelled" ?  Colors.red
                                    : Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text(
                            "Scan Type : ", style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(
                            totalAppointments['scanType'], style: const TextStyle(
                              // color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight
                              .w400),)
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Total Appointments"),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child:  Container(
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(12),
                //         boxShadow: const [
                //           BoxShadow(
                //             color: Colors.black26,
                //             blurRadius: 5,
                //           )
                //         ],
                //         border: Border.all(width: 1, color: Colors.black12)
                //     ),
                //     child: Column(
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Column(
                //             children: [
                //               const Text("Total Appointments", style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                //               const SizedBox(height: 8,),
                //               Text(total.toString(), style: const TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                //             ],
                //           ),
                //         ),
                //         const SizedBox(height: 10,),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 15.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Column(
                //                 children: [
                //                   const Text("Completed", style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                //                   const SizedBox(height: 8,),
                //                   Text(complete.toString(), style: const TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.w600),),
                //                 ],
                //               ),
                //               Column(
                //                 children: [
                //                   const Text("Pending", style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                //                   const SizedBox(height: 8,),
                //                   Text(incomplete.toString(), style: const TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.w600),),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                FirebaseAnimatedList(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    if(snapshot.exists) {
                      stopLoading();
                      Map allAppointments = snapshot.value as Map;
                      allAppointments['key'] = snapshot.key;

                      allAppointments['appointmentStatus'] == "pending" ? incomplete++ : complete++;
                      // allAppointments['appointmentStatus'] == "complete" ? complete+=1 : incomplete+=1;
                      total = index+1;

                      // setState(() {
                      //
                      // });

                      return listItem(totalAppointments: allAppointments,i: index);
                    }
                    else if(snapshot.isBlank == true){
                      return const Image(
                        image: AssetImage('assets/images/no_data_found.png'),
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
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

  Future stopLoading() {
    return Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

}
