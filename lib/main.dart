import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';
import 'package:user_app_clinic/firebase_options.dart';
import 'package:user_app_clinic/screens/appointment/appointment/appointments_page.dart';
import 'package:user_app_clinic/screens/appointment/appointment/total_appointment_status.dart';
import 'package:user_app_clinic/screens/home_screens/dashboard.dart';
import 'package:user_app_clinic/src/repository/authentication_repository.dart';
import 'package:user_app_clinic/src/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controller/database_controller/appointments/controller.dart';

// void main() {
//   runApp(const MyApp());
// }

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context,_) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      ThemeMode themeMode = themeProvider.themeMode;
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User App Clinic',
        // theme: ThemeData(
        //   brightness: Brightness.light,
        //   primarySwatch: generateMaterialColor(color: Color(0xFF0527DB))
        // ),
        // darkTheme: ThemeData(
        //     brightness: Brightness.dark,
        //     primarySwatch: generateMaterialColor(color: Color(0xFFFFFFFF))
        // ),
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        // themeMode: themeProvider.themeMode,
        themeMode: themeMode,
        routes: {
          "/appointment_status": (ctx) => const AppointmentsPage(),
          "/home_page": (ctx) => const DashboardPage(),
          // "/second": (ctx) => SecondScreen(),
        },
        home: const DashboardPage(),
      );
    },

  );


}


