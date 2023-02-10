import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:user_app_clinic/screens/appointment/book_an_appointment.dart';

class TimeStampList extends StatefulWidget {
  const TimeStampList({Key? key}) : super(key: key);

  @override
  State<TimeStampList> createState() => _TimeStampListState();
}

class _TimeStampListState extends State<TimeStampList> {

  Query dbRef = FirebaseDatabase.instance.ref('Time Slots').child('27-12-2022');
  DatabaseReference reference = FirebaseDatabase.instance.ref('Time Slots').child('27-12-2022');

  var selcected = null;

  Widget listItem({required Map timeslots}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          // height: 110,
          decoration: BoxDecoration(
            border: selcected == timeslots['time'] ? Border.all(color: Colors.white,width: 3): null,
            color: timeslots['status'] == false ? Colors.red : const Color(0xFF445DE2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: selcected == timeslots['time'] ? Colors.black54 : Colors.transparent,
                blurRadius: 10,
              )
            ]
          ),
          child: GestureDetector(
            onTap: () async{
              setState(() {
                if(timeslots['status'] == false ){
                  selcected = null;
                }else {
                  selcected = timeslots['time'];
                }
              });
              // print({selcected: timeslots['time']});
              // Map<String, bool> timeslotsUpdate = {
              //   'status': false,
              // };
              // reference.child(timeslots['key']).update(timeslotsUpdate);
              // reference.child(selcected).update(timeslotsUpdate);
              // BookAnAppointment.time = selcected;
              // BookAnAppointment.updateTimeSlot(selcected, timeslots['key']);
              BookAnAppointment.time = selcected;
              BookAnAppointment.index = timeslots['key'];
              // print(selcected);
              // print(timeslots['key']);
            },
            child: Text(
              timeslots['time'],
              style: const TextStyle(fontSize: 15,color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Align(
            child: timeslots['status'] == false ? const Text("Booked",style: TextStyle(color: Colors.red,fontSize: 12),) : null
        ),
        const SizedBox(height: 8,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selcected = null;
      }),
      child: FirebaseAnimatedList(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map allTimeSlots = snapshot.value as Map;
              allTimeSlots['key'] = snapshot.key;

              return listItem(timeslots: allTimeSlots);
            },
          ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   int? _value = 2;
  //   bool select = false;
  //   final timeStamp = [
  //     '09:30AM - 10:30AM',
  //     '10:30AM - 11:30AM',
  //     '11:30AM - 12:30PM',
  //     '12:30PM - 01:30PM',
  //     '02:30PM - 03:30PM',
  //     '03:30PM - 04:30PM',
  //     '04:30PM - 05:30PM',
  //     '05:30PM - 06:30PM',
  //     '06:30PM - 07:30PM'
  //   ];
  //   return Container();
  //   // Container(
  //   //   child: SingleChildScrollView(
  //   //     scrollDirection: Axis.horizontal,
  //   //     child: Wrap(
  //   //       spacing: 8,
  //   //       children: List.generate(
  //   //         timeStamp.length,
  //   //             (int index) {
  //   //           return ChoiceChip(
  //   //             backgroundColor: const Color(0xFF0527DB),
  //   //             padding: const EdgeInsets.all(12),
  //   //             disabledColor: Colors.black,
  //   //             label: Text(timeStamp[index],style: TextStyle(color: Colors.white),),
  //   //             selectedColor: Colors.red,
  //   //             selected: _value == index,
  //   //             onSelected: (bool selected) {
  //   //               setState(() {
  //   //                 _value = index ;
  //   //               });
  //   //             },
  //   //           );
  //   //         },
  //   //       ).toList(),
  //   //     ),
  //   //   ),
  //   // );
  //   DatabaseReference getTimeSlots = FirebaseDatabase.instance.ref('Time Slots/24-12-2022');
  //   // return StreamBuilder(
  //   //   stream: getTimeSlots.onValue,
  //   //   builder: (context, snapshot) {
  //   //     if (snapshot.hasData) {
  //   //       DataSnapshot dataValues = snapshot.data.snapshot; //Error: The getter snapshot is not defined for the type 'Object';
  //   //       Map<dynamic, dynamic> values = dataValues.value;
  //   //       values.forEach((key, values) {
  //   //         messages.add(values);
  //   //       });
  //   //       return new ListView.builder(
  //   //         shrinkWrap: true,
  //   //         itemCount: messages.length,
  //   //         itemBuilder: (BuildContext context, int index) {
  //   //           return Card(
  //   //             child: Column(
  //   //               crossAxisAlignment: CrossAxisAlignment.start,
  //   //               children: <Widget>[
  //   //                 Text("Name: " + messages[index]["Text"]),
  //   //                 Text("Time: " + messages[index]["TextTime"]),
  //   //               ],
  //   //             ),
  //   //           );
  //   //         },
  //   //       );
  //   //     }
  //   //   },
  //   // ),
  // }
  //
  // // @override
  // // void initState() {
  // //   DatabaseReference getTimeSlots = FirebaseDatabase.instance.ref('Time Slots/24-12-2022');
  // //   getTimeSlots.onValue.listen(
  // //           (DatabaseEvent event) {
  // //     final data = event.snapshot.value;
  // //     // updateStarCount(data);
  // //   });
  // // }
}
