import 'package:user_app_clinic/screens/appointment/scannings/scanning_loading.dart';

import '../../../controller/database_controller/scannings/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'all_available_scannings.dart';

class ScanningsPage extends StatelessWidget {
  const ScanningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () {
          if (scanningController.isLoading.value) {
            return const Center(
              child: ScanningLoading(),
            );
          } else {
            if (scanningController.scanningItemList.isNotEmpty) {
              return AvailableScanning(data: scanningController.scanningItemList,);
            }
            else {
              return const Center(
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: const [
                //     Icon(Icons.hourglass_empty),
                //     Text("No Data Available ...")
                //   ],
                // ),
              );
            }
          }
        },
      ),
    );
  }
}