import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScanningLoading extends StatelessWidget {
  const ScanningLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book An Appointment"),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData.fallback(),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade400,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child:ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
          ); },
      ),
    );
  }
}