import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_clinic/src/theme/theme.dart';

// class ChangeThemeButton extends StatelessWidget {
//   const ChangeThemeButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Switch.adaptive(
//         value: themeProvider.isDarkMode,
//         onChanged: (value) {
//           final provider = Provider.of<ThemeProvider>(context,listen: true);
//           provider.toggleTheme(value);
//         }
//     );
//   }
// }

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}