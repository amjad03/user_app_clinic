import 'package:flutter/material.dart';

enum Gender {Male, Female, Others}

class MyRadioButton extends StatelessWidget {
  MyRadioButton({Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged
  }) : super(key: key);

  String title;
  Gender value;
  Gender? groupValue;
  Function(Gender?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
          alignment: Alignment.center,
          child: RadioListTile<Gender>(
              contentPadding: const EdgeInsets.all(0.0),
              value: Gender.Male,
              groupValue: groupValue,
              dense: true,
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45),
                borderRadius: BorderRadius.circular(5.0),
              ),
              // tileColor: Colors.blue[50],
              title: Text(title),
              onChanged: onChanged
          ),
        ),
      );
  }
}
