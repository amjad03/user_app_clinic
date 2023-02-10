// import 'package:flutter/material.dart';
// import 'book_an_appointment.dart';
//
// class ScanningAvailable extends StatefulWidget {
//   const ScanningAvailable({Key? key}) : super(key: key);
//
//   @override
//   State<ScanningAvailable> createState() => _ScanningAvailableState();
// }
//
// class _ScanningAvailableState extends State<ScanningAvailable> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Scanning Available",style: TextStyle(color: Colors.black),),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData.fallback(),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             InkWell(child: scanCard("assets/images/banner1.jpeg","MRI Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//               },
//             ),
//             InkWell(child: scanCard("assets/images/banner1.jpeg","CT Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//                 },
//             ),
//             InkWell(child: scanCard("assets/images/banner1.jpeg","Full Body Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//               },
//             ),
//             InkWell(child: scanCard("assets/images/banner1.jpeg","Half Body Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//               },
//             ),
//             InkWell(child: scanCard("assets/images/banner1.jpeg","Heart Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//               },
//             ),
//             InkWell(child: scanCard("assets/images/banner1.jpeg","X-Ray Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//               },
//             ),
//             InkWell(child: scanCard("assets/images/banner1.jpeg","Head Scanning","This is very safest scanning and this is very cost effective in the sense of health and wealth."),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAnAppointment()));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// Widget scanCard(String img,String title,String subtitle){
//   return Container(
//     margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
//     width: 500,
//     height: 200,
//     decoration: BoxDecoration(
//       // color: Colors.indigo,
//       borderRadius: BorderRadius.circular(12),
//       image: const DecorationImage(
//         image: AssetImage('assets/images/new_bg.png'),
//         fit: BoxFit.fill
//       ),
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black26,
//           blurRadius: 10
//         )
//       ]
//     ),
//     child: Container(
//       width: 380,
//       height: 80,
//       margin: const EdgeInsets.only(left: 140,right: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.transparent,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
//           SizedBox(height: 12,),
//           Text(subtitle,style: TextStyle(color: Colors.black54),textAlign: TextAlign.center,)
//         ],
//       ),
//     )
//   );
// }