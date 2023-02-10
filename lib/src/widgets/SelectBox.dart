import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  SelectBox({Key? key,
    required this.title
  }) : super(key: key);
  String title;

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
        // const SizedBox(width: 5,),
        Text(widget.title,style: TextStyle(fontSize: 17),)
      ],
    );
  }
}