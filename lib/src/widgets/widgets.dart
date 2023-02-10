import 'package:flutter/material.dart';


Widget textFieldWithoutIcon(String title,TextInputType type,bool address) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: TextFormField(
      textAlign: TextAlign.start,
      cursorColor: Colors.grey,
      keyboardType: type,
      maxLines: address ? 4 : 1,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          label: Text(title),
          border: const OutlineInputBorder(),
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