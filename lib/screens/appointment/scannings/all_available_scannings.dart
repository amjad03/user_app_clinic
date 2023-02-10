import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../models/database/scannings_model.dart';
import '../book_an_appointment.dart';



class AvailableScanning extends StatefulWidget {
  final List<ScanningsModel> data;

  const AvailableScanning({Key? key, required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AvailableScanningState();
  }
}

class _AvailableScanningState extends State<AvailableScanning> {
  int _current = 0;
  late List<Widget> allScannings;
  @override
  void initState() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    allScannings = widget.data.map(
      (item) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookAnAppointment(duration: item.duration,
            type: item.title, price: item.price,)));
        },
        child: Container(
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            width: 500,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: brightness == Brightness.light ? AssetImage('assets/images/new_bg.png') : AssetImage('assets/images/bg_dark.jpg'),
                    fit: BoxFit.fill
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10
                  )
                ]
            ),
            child: Container(
              width: 380,
              height: 80,
              margin: const EdgeInsets.only(left: 140,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  const SizedBox(height: 12,),
                  Text(item.desc,style: const TextStyle(color: Colors.black54),textAlign: TextAlign.center,)
                ],
              ),
            )
        ),
      )
    ).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book An Appointment"),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData.fallback(),
      ),
    body: SingleChildScrollView(
      child: Column(
        children: allScannings,
      ),
    )
    //   body: ListView.builder(
    //     itemCount: allScannings.length,
    //       itemBuilder: (BuildContext context, int index) =>
    //       allScannings.
    // // Container(
    //   //     margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
    //   //     width: 500,
    //   //     height: 200,
    //   //     decoration: BoxDecoration(
    //   //         borderRadius: BorderRadius.circular(12),
    //   //         image: const DecorationImage(
    //   //             image: AssetImage('assets/images/new_bg.png'),
    //   //             fit: BoxFit.fill
    //   //         ),
    //   //         boxShadow: const [
    //   //           BoxShadow(
    //   //               color: Colors.black26,
    //   //               blurRadius: 10
    //   //           )
    //   //         ]
    //   //     ),
    //   //     child: Container(
    //   //       width: 380,
    //   //       height: 80,
    //   //       margin: const EdgeInsets.only(left: 140,right: 10),
    //   //       decoration: BoxDecoration(
    //   //         borderRadius: BorderRadius.circular(12),
    //   //         color: Colors.transparent,
    //   //       ),
    //   //       child: Column(
    //   //         mainAxisAlignment: MainAxisAlignment.center,
    //   //         children: [
    //   //           Text("Title",style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    //   //           const SizedBox(height: 12,),
    //   //           Text("desc",style: const TextStyle(color: Colors.black54),textAlign: TextAlign.center,)
    //   //         ],
    //   //       ),
    //   //     )
    //   // )
    //   ),
    );
  }

}