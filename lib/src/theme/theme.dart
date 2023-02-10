import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// class ATheme {
//   ATheme._();
//
//   static ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue
//   );
//
//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//       primarySwatch: const MaterialColor(0xFF0527DB, <int, Color>{
//         50 : Color(0xFF000000),
//         100 : Color(0xFF000000),
//         200 : Color(0xFF000000),
//         300 : Color(0xFF000000),
//         400 : Color(0xFF000000),
//         500 : Color(0xFF000000),
//         600 : Color(0xFF000000),
//         700 : Color(0xFF000000),
//         800 : Color(0xFF000000),
//         900 : Color(0xFF000000),
//       })
//   );
//
//   // static ThemeData lightTheme = ThemeData(
//   //   // primarySwatch: const MaterialColor(0xFF000000, <int, Color>{
//   //   //   50 : Color(0xFF000000),
//   //   //   100 : Color(0xFF000000),
//   //   //   200 : Color(0xFF000000),
//   //   //   300 : Color(0xFF000000),
//   //   //   400 : Color(0xFF000000),
//   //   //   500 : Color(0xFF000000),
//   //   //   600 : Color(0xFF000000),
//   //   //   700 : Color(0xFF000000),
//   //   //   800 : Color(0xFF000000),
//   //   //   900 : Color(0xFF000000),
//   //   // }),
//   //   primarySwatch: Colors.yellow,
//   //   brightness: Brightness.light,
//   //   textTheme: TTextTheme.lightTextTheme,
//   //   appBarTheme: AppBarTheme(),
//   //   floatingActionButtonTheme: FloatingActionButtonThemeData(),
//   //   elevatedButtonTheme:
//   //   ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
//   // );
//   //
//   //
//   // static ThemeData darkTheme = ThemeData(
//   //   primarySwatch: Colors.yellow,
//   //   brightness: Brightness.dark,
//   //   textTheme: TTextTheme.darkTextTheme,
//   //   appBarTheme: AppBarTheme(),
//   //   floatingActionButtonTheme: FloatingActionButtonThemeData(),
//   //   elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
//   // );
// }

// class ThemeProvider extends ChangeNotifier{
//   ThemeMode themeMode = ThemeMode.light;
//
//   bool get isDarkMode => themeMode == ThemeMode.dark;
//
//   void toggleTheme(bool isOn){
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }
//
//
// class MyTheme{
//   // Color color = generateMaterialColor(color: Color(0xFFFFFFFF));
//   static final darkTheme = ThemeData(
//     // primarySwatch: generateMaterialColor(color: Color(0xFF0527DB)),
//     // scaffoldBackgroundColor: Colors.grey.shade900,
//     // primaryColor: Colors.black,
//     // // appBarTheme: AppBarTheme(
//     // //   color: Colors.grey.shade900
//     // // ),
//     // brightness: Brightness.dark,
//     // colorScheme: const ColorScheme.dark()
//     scaffoldBackgroundColor: Colors.grey.shade900,
//     primaryColor: Colors.black,
//     colorScheme: ColorScheme.dark(),
//     // iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
//     primarySwatch: generateMaterialColor(color: Color(0xFFFFFFFF))
//   );
//
//   static final lightTheme = ThemeData(
//     // primarySwatch: generateMaterialColor(color: Color(0xFF0527DB)),
//     // scaffoldBackgroundColor: Colors.white,
//     // primaryColor: Colors.white,
//     // // appBarTheme: const AppBarTheme(
//     // //     color: Colors.white
//     // // ),
//     // brightness: Brightness.light,
//     //   colorScheme: const ColorScheme.light()
//     scaffoldBackgroundColor: Colors.white,
//     primaryColor: Colors.white,
//     colorScheme: ColorScheme.light(),
//     // iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
//   );
// }


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    // iconTheme: IconThemeData(color: Colors.grey.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    // scaffoldBackgroundColor: Colors.white,
    // primaryColor: Colors.white,
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    colorScheme: ColorScheme.light(),
    // iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}

