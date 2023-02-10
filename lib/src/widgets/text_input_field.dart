import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        textAlign: TextAlign.start,
        // cursorColor: Colors.grey,
        obscureText: widget.password ? _obsecureText : false,
        keyboardType: widget.type,
        maxLines: widget.address ? 4 : 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
            label: Text(widget.title),
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.password ? GestureDetector(
              child: _obsecureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              onTap: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
            ) : null,
            border: const OutlineInputBorder(),
            iconColor: Colors.black45,
            // labelStyle: const TextStyle(color: Colors.black45),
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




