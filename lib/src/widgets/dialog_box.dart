import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  CustomDialogBox({Key? key,
  required this.title
  }) : super(key: key);

  String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title!'),
      actions: <Widget>[
        TextButton(
          child: const Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}


// Future<void> _showMyDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Approve'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
Widget boldText(String text){
  return Text(
    text,
    style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold
    ),
  );
}

// Future<void> _showMyDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Confirm Booking!'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Row(
//                 children: [
//                   boldText("Name :"),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const Text("User Name")
//                 ],
//               ),
//               const SizedBox(height: 7,),
//               Row(
//                 children: [
//                   boldText("Scan Type :"),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const Text("CT Scan")
//                 ],
//               ),
//               const SizedBox(height: 7,),
//               Row(
//                 children: [
//                   boldText("Scan Amount :"),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const Text("Rs: 1500/-")
//                 ],
//               ),
//               const SizedBox(height: 7,),
//               Row(
//                 children: [
//                   boldText("Date :"),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const Text("12/11/2022")
//                 ],
//               ),
//               const SizedBox(height: 7,),
//               Row(
//                 children: [
//                   boldText("Time"),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   const Text("12:30 - 01:30 pm")
//                 ],
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Confirm'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }