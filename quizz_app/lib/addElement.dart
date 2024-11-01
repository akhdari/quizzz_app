import 'package:flutter/material.dart';
//The Icon widget, along with Colors, Text, TextButton, and many other Flutter UI elements, are defined in the material.dart library
class AddElement {
    Icon addElement(bool isTrue) {
    if (isTrue) {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return Icon(Icons.close, color: Colors.red);
    }
  }
}