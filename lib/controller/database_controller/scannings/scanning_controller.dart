import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/database/scannings_model.dart';
import '../../../src/services/scannings_service/scanning_service.dart';


class ScanningController extends GetxController {
  // static CarouselController instance = Get.find();
  static ScanningController instance = Get.put(ScanningController());
  RxList<ScanningsModel> scanningItemList = List<ScanningsModel>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    try {
      isLoading(true);
      var result = await ScanningService().getScannings();
      scanningItemList.assignAll(result);
    }catch(e) {
      debugPrint(e.toString());
    }finally {
      isLoading(false);
    }
  }
}