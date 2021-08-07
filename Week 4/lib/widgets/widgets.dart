import 'package:flutter/material.dart';





InputDecoration textFieldInputDecoration(String hint){
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black45),
    ),
    );

}

