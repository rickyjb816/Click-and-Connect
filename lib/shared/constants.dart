import 'package:flutter/material.dart';


const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
    ),
    //hintStyle: TextStyle(color: Colors.black),
    labelStyle: TextStyle(color: mainColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
    )
);

final buttonShape = BeveledRectangleBorder(borderRadius: BorderRadius.circular(10));
const buttonColor = Color.fromRGBO(7, 118, 152, 1);
const buttonTextColor = Colors.white;

const mainColor = Color.fromRGBO(7, 118, 152, 1);
const secondaryColor = Color.fromRGBO(0, 102, 102, 1);
const tertiaryColor = Color.fromRGBO(255, 255, 255, 1);
const disabledColor = Colors.grey;

const double radius = 30;