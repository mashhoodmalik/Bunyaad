import 'package:flutter/material.dart';

class Style{


  static Color defaultHeadingColor = Color(0xff192b8d);

  static Color backgroundColor() => Colors.white;

  static TextStyle heading ()=>TextStyle(
      color: defaultHeadingColor,
      fontSize: 38,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);

  static ButtonStyle primaryButtonStyle({Color buttonColor = const Color(0xff192b8d)}) {
    return ElevatedButton.styleFrom(
      primary: buttonColor,
      fixedSize: Size(120, 30),
    );
  }



  static InputDecoration fieldsDecoration({required String hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      enabledBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(50),
      ),
      disabledBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(50),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(50),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(50),
      ),
      contentPadding: const EdgeInsets.all(10),
      border: InputBorder.none,
      hintText: hintText,
      errorStyle: const TextStyle(fontSize: 12),
      hintStyle: TextStyle(color: Colors.black45),
    );
  }

  static InputDecoration createRequestFieldsDecoration({required String hintText}) {
    return InputDecoration(
      // filled: true,
      // fillColor: Colors.grey[300],
      enabledBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        // borderRadius: BorderRadius.circular(50),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        // borderRadius: BorderRadius.circular(50),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 20,
        borderSide: BorderSide(color: Colors.black87),
        // borderRadius: BorderRadius.circular(50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
        // borderRadius: BorderRadius.circular(50),
      ),
      contentPadding: const EdgeInsets.all(10),
      border: InputBorder.none,
      hintText: hintText,
      errorStyle: const TextStyle(fontSize: 12),
      hintStyle: TextStyle(color: Colors.black45),
    );
  }

}