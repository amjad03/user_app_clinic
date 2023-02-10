import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.title,
    required this.icon,
    required this.type,
    required this.password,
    required this.address
  }) : super(key: key);
  String title;
  IconData icon;
  TextInputType type;
  bool password;
  bool address;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        obscureText: password ? true : false,
        keyboardType: type,
        maxLines: address ? 4 : 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
            label: Text(title),
            prefixIcon: Icon(icon),
            suffixIcon: password ? const Icon(Icons.remove_red_eye) : null,
            border: const OutlineInputBorder(),
            iconColor: Colors.black45,
            labelStyle: const TextStyle(color: Colors.black45),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.black45
              ),
            )
        ),
      ),
    );
  }
}