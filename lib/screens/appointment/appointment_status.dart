import 'package:flutter/material.dart';
import 'package:user_app_clinic/screens/appointment/appointment_detail.dart';

class AppointmentStatus extends StatefulWidget {
  const AppointmentStatus({Key? key}) : super(key: key);

  @override
  State<AppointmentStatus> createState() => _AppointmentStatusState();
}

class _AppointmentStatusState extends State<AppointmentStatus> {

  @override
  Widget build(BuildContext context) {

    Widget card(String name,String date,String status,String type,bool completed){
      Widget patientDetails(name,no){
        String? title;
        switch(no){
          case 1:
            title = "Name";
            break;
          case 2:
            title = "Date";
            break;
          case 3:
            title = "Status";
            break;
          case 4:
            title = "Scan Type";
            break;
        }
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text("${title!} : ",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              Text(name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18),)
            ],
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: completed ? Colors.green : Colors.blue
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 17,),
            child: Column(
              children: [
                patientDetails(name,1),
                patientDetails(date,2),
                patientDetails(status,3),
                patientDetails(type,4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentDetails()));
                      },
                      child: const Text(
                        "more",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // const Icon(Icons.arrow_forward_outlined,size: 20,)
                  ],
                )
              ],
            ),
          ),
        ),
      );

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Status"),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData.fallback(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textCard("Total Appointments", "4",Colors.blue),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textCard("Completed", "3",Colors.green),
                  const SizedBox(width: 20,),
                  textCard("Pending", "1",Colors.red),
                ],
              ),
              const SizedBox(height: 20,),
              const Divider(height: 1,color: Colors.black26,),
              const SizedBox(height: 10,),
              card("Patient Name", "11/12/2022", "Pending", "CT Scan", false),
              card("Patient Name", "11/12/2022", "Completed", "CT Scan", true),
              card("Patient Name", "11/12/2022", "Completed", "CT Scan", true),
              card("Patient Name", "11/12/2022", "Completed", "CT Scan", true),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textCard(String title,String subtitle,Color color){
  Color colors = color;
  return Container(
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5
        )
      ],
      borderRadius: BorderRadius.circular(12),
      color: Colors.white
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 35.0,right: 35,top: 11,bottom: 11),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          Text(subtitle,style: TextStyle(color: colors,fontSize: 24,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  );
}

// Widget card(String name,String date,String status,String type,bool completed){
//   Widget patientDetails(name,no){
//     String? title;
//     switch(no){
//       case 1:
//         title = "Name";
//         break;
//       case 2:
//         title = "Date";
//         break;
//       case 3:
//         title = "Status";
//         break;
//       case 4:
//         title = "Scan Type";
//         break;
//     }
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Row(
//         children: [
//           Text("${title!} : ",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
//           Text(name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18),)
//         ],
//       ),
//     );
//   }
//   return Padding(
//     padding: const EdgeInsets.all(7.0),
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: completed ? Colors.green : Colors.blue
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0,top: 17,),
//         child: Column(
//           children: [
//             patientDetails(name,1),
//             patientDetails(date,2),
//             patientDetails(status,3),
//             patientDetails(type,4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                     onPressed: (){},
//                     child: const Text(
//                       "more",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                 ),
//                 // const Icon(Icons.arrow_forward_outlined,size: 20,)
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
//
// }


