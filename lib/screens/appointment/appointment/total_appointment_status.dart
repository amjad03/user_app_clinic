import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../models/database/total_appointment_model.dart';
import '../appointment_detail.dart';
import '../book_an_appointment.dart';
import 'appointments_page.dart';

var total;
int complete = 0,
    incomplete = 0;

class TotalAppointmentStatus extends StatefulWidget {
  final List<TotalAppointmentModel> data;

  const TotalAppointmentStatus({Key? key, required this.data,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TotalAppointmentStatusState();
  }
}

class _TotalAppointmentStatusState extends State<TotalAppointmentStatus> {
  int _current = 0;

  late List<Widget> allAppointments;

  @override
  void initState() {
    getData();
    // allAppointments = widget.data.map(
    //         (item) {
    //       item.appointmentStatus == "true" ? complete++ : incomplete++;
    //
    //       return GestureDetector(
    //         onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetails(
    //                   address: item.address,
    //                   age: item.age,
    //                   appointmentStatus: item.appointmentStatus,
    //                   blood: item.blood,
    //                   date: item.date,
    //                   gender: item.gender,
    //                   name: item.name,
    //                   paymentStatus: item.paymentStatus,
    //                   phone: item.phone,
    //                   scanAmount: item.scanAmount,
    //                   scanType: item.scanType,
    //                   time: item.time,
    //                 )
    //             )
    //           );
    //         },
    //         child: Container(
    //             margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    //             // width: 500,
    //             // height: 200,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(12),
    //                 // image: DecorationImage(
    //                 //     image: brightness == Brightness.light ? AssetImage('assets/images/new_bg.png') : AssetImage('assets/images/bg_dark.jpg'),
    //                 //     fit: BoxFit.fill
    //                 // ),
    //                 color: item.appointmentStatus == "true"
    //                     ? Colors.green
    //                     : Colors.blue,
    //                 boxShadow: const [
    //                   BoxShadow(
    //                       color: Colors.black26,
    //                       blurRadius: 10
    //                   )
    //                 ]
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.all(12.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       const Text(
    //                         "Patient Name : ", style: TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .bold),),
    //                       Text(item.name, style: const TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .w400),)
    //                     ],
    //                   ),
    //                   const SizedBox(height: 5,),
    //                   Row(
    //                     children: [
    //                       const Text("Date : ", style: TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .bold),),
    //                       Text(item.date, style: const TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .w400),)
    //                     ],
    //                   ),
    //                   const SizedBox(height: 5,),
    //                   Row(
    //                     children: [
    //                       const Text("Status : ", style: TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .bold),),
    //                       Text(item.appointmentStatus,
    //                         style: const TextStyle(color: Colors.white,
    //                             fontSize: 18,
    //                             fontWeight: FontWeight.w400),)
    //                     ],
    //                   ),
    //                   const SizedBox(height: 5,),
    //                   Row(
    //                     children: [
    //                       const Text(
    //                         "Scan Type : ", style: TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .bold),),
    //                       Text(
    //                         item.scanType, style: const TextStyle(color: Colors
    //                           .white, fontSize: 18, fontWeight: FontWeight
    //                           .w400),)
    //                     ],
    //                   ),
    //                   // Align(
    //                   //   alignment: Alignment.center,
    //                   //   child: TextButton(
    //                   //     onPressed: () {},
    //                   //     child: const Text(
    //                   //       "More Information", style: TextStyle(color: Colors
    //                   //         .tealAccent),),
    //                   //   ),
    //                   // )
    //                   // Text(item.title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    //                   // const SizedBox(height: 12,),
    //                   // Text(item.desc,style: const TextStyle(color: Colors.black54),textAlign: TextAlign.center,)
    //                 ],
    //               ),
    //             )
    //         ),
    //       );
    //     }
    // ).toList();
    // total = allAppointments.length;
    // Future<void> getData()async{
    //   User? user = await FirebaseAuth.instance.currentUser;
    //   var thisUser = user?.uid.toString() as String;
    //
    //   DatabaseReference ref = FirebaseDatabase.instance.ref("Appointments").child(thisUser);
    //
    //   DatabaseReference address1 = ref.child('address');
    //   DatabaseEvent event1 = await address1.once();
    //   address = event1.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference age1 = ref.child('age');
    //   DatabaseEvent event2 = await age1.once();
    //   age = event2.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference appointmentStatus1 = ref.child('appointmentStatus');
    //   DatabaseEvent event3 = await appointmentStatus1.once();
    //   appointmentStatus = event3.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference blood1 = ref.child('blood');
    //   DatabaseEvent event4 = await blood1.once();
    //   blood = event4.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference date1 = ref.child('date');
    //   DatabaseEvent event5 = await date1.once();
    //   date = event5.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference gender1 = ref.child('gender');
    //   DatabaseEvent event6 = await gender1.once();
    //   gender = event6.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference name1 = ref.child('name');
    //   DatabaseEvent event7 = await name1.once();
    //   name = event7.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference paymentStatus1 = ref.child('paymentStatus');
    //   DatabaseEvent event8 = await paymentStatus1.once();
    //   paymentStatus = event8.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference phone1 = ref.child('phone');
    //   DatabaseEvent event9 = await phone1.once();
    //   phone = event9.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference scanAmount1 = ref.child('scanAmount');
    //   DatabaseEvent event10 = await scanAmount1.once();
    //   scanAmount = event10.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference scanType1 = ref.child('scanType');
    //   DatabaseEvent event11 = await scanType1.once();
    //   scanType = event11.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference time1 = ref.child('time');
    //   DatabaseEvent event12 = await time1.once();
    //   time = event12.snapshot.value.toString() as DatabaseReference;
    //
    //   DatabaseReference userId1 = ref.child('userId');
    //   DatabaseEvent event13 = await userId1.once();
    //   userId = event13.snapshot.value.toString() as DatabaseReference;
    //
    // }
    // getData();
    super.initState();
  }

  void getData() {
    allAppointments = widget.data.map(
            (item) {
          item.appointmentStatus == "pending" ? incomplete++ : complete++;

          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetails(
                keys: '',
                address: item.address,
                age: item.age,
                appointmentStatus: item.appointmentStatus,
                blood: item.blood,
                date: item.date,
                gender: item.gender,
                name: item.name,
                paymentStatus: item.paymentStatus,
                phone: item.phone,
                scanAmount: item.scanAmount,
                scanType: item.scanType,
                time: item.time,
              )
              )
              );
            },
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                // width: 500,
                // height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // image: DecorationImage(
                    //     image: brightness == Brightness.light ? AssetImage('assets/images/new_bg.png') : AssetImage('assets/images/bg_dark.jpg'),
                    //     fit: BoxFit.fill
                    // ),
                    color: item.appointmentStatus == "complete"
                        ? Colors.green
                        : Colors.blue,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Patient Name : ", style: TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(item.name, style: const TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .w400),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text("Date : ", style: TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(item.date, style: const TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .w400),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text("Status : ", style: TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(item.appointmentStatus,
                            style: const TextStyle(color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          const Text(
                            "Scan Type : ", style: TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .bold),),
                          Text(
                            item.scanType, style: const TextStyle(color: Colors
                              .white, fontSize: 18, fontWeight: FontWeight
                              .w400),)
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: const Text(
                      //       "More Information", style: TextStyle(color: Colors
                      //         .tealAccent),),
                      //   ),
                      // )
                      // Text(item.title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      // const SizedBox(height: 12,),
                      // Text(item.desc,style: const TextStyle(color: Colors.black54),textAlign: TextAlign.center,)
                    ],
                  ),
                )
            ),
          );
        }
    ).toList();
    total = allAppointments.length;
  }

  void clear(){
    setState(() {
      complete = incomplete = 0;
    });
  }
  @override
  void dispose() {
    clear();
    super.dispose();
  }

  Future refresh() async{
    // initState();
    // getData();
    // AppointmentsPage();
    // await AppointmentsPage();
    Navigator.pop(context);
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentsPage()));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentsPage()));

    // Navigator.popAndPushNamed(context, "/appointment_status");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Appointment Status"),
          centerTitle: true,
          // backgroundColor: Colors.white,
          // iconTheme: const IconThemeData.fallback(),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: total > 0 ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                          )
                        ],
                        border: Border.all(width: 1, color: Colors.black12)
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              const Text("Total Appointments", style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 8,),
                              Text(total.toString(), style: const TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text("Completed", style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                                  const SizedBox(height: 8,),
                                  Text(complete.toString(), style: const TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.w600),),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("Pending", style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.w600),),
                                  const SizedBox(height: 8,),
                                  Text(incomplete.toString(), style: const TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ) : null,
                ),
                // Column(
                //   children: allAppointments,
                // ),
                ListView(
                  padding: const EdgeInsets.only(bottom: 20),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  reverse: true,
                  children: allAppointments,
                ),
                const SizedBox(
                    width: 500,
                    height: 200,
                ),
                const SizedBox(
                  width: 500,
                  height: 200,
                ),
                const SizedBox(
                  width: 500,
                  height: 200,
                ),
                const SizedBox(
                  width: 500,
                  height: 200,
                ),
                const SizedBox(
                  width: 500,
                  height: 200,
                ),

              ],
            ),
            //       child: Container(
            //               margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            //               width: 500,
            //               height: 200,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   // color: item.appointmentStatus == true ? Colors.green : Colors.blue,
            //                   boxShadow: const [
            //                     BoxShadow(
            //                         color: Colors.black26,
            //                         blurRadius: 10
            //                     )
            //                   ]
            //               ),
            //               child: Container(
            //                 width: 380,
            //                 height: 80,
            //                 margin: const EdgeInsets.only(left: 140,right: 10),
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: Colors.transparent,
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         const Text("Patient Name : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            //                         Text(item.name,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)
            //                       ],
            //                     ),
            //                     Row(
            //                       children: [
            //                         const Text("Date : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            //                         Text(item.date,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)
            //                       ],
            //                     ),
            //                     Row(
            //                       children: [
            //                         const Text("Status : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            //                         Text(item.appointmentStatus,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)
            //                       ],
            //                     ),
            //                     Row(
            //                       children: [
            //                         const Text("Scan Type : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            //                         Text(item.scanType,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)
            //                       ],
            //                     ),
            //
            //                     // Text(item.title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            //                     // const SizedBox(height: 12,),
            //                     // Text(item.desc,style: const TextStyle(color: Colors.black54),textAlign: TextAlign.center,)
            //                   ],
            //                 )
            // );
            //           }
            //       ),
          ),
        )
    );
  }

}