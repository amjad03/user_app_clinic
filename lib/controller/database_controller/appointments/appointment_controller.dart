import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/database/scannings_model.dart';
import '../../../models/database/total_appointment_model.dart';
import '../../../src/services/appointment_service/appointment_service.dart';
import '../../../src/services/scannings_service/scanning_service.dart';


class AppointmentController extends GetxController {
  // static CarouselController instance = Get.find();
  static AppointmentController instance = Get.put(AppointmentController());
  RxList<TotalAppointmentModel> appointmentItemList = List<TotalAppointmentModel>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    try {
      isLoading(true);
      var result = await AppointmentService().getAppointments();
      appointmentItemList.assignAll(result);
    }catch(e) {
      debugPrint(e.toString());
    }finally {
      isLoading(false);
    }
  }
}