
import 'package:user_app_clinic/screens/appointment/appointment/total_appointment_status.dart';
import 'package:user_app_clinic/screens/appointment/scannings/scanning_loading.dart';

import '../../../controller/database_controller/appointments/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appointments.dart';
import 'appointments_loading.dart';

// import 'all_available_scannings.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(
              () {
            if (appointmentController.isLoading.value) {
              return const Center(
                child: AppointmentsLoading(),
              );
            } else {
              if (appointmentController.appointmentItemList.isNotEmpty) {
                return TotalAppointmentStatus(data: appointmentController.appointmentItemList,);
                // return TotalAppointments();
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Appointment Status'),
                    centerTitle: true,
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      // Icon(Icons.hourglass_empty),
                      // Text("No Data Available ...")
                      Image(
                        image: AssetImage('assets/images/no_data_found.png'),
                      )
                    ],
                  )
                );
              }
            }
          },
        ),
      ),
    );
  }
}