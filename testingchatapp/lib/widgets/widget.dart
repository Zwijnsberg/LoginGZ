import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Color.fromRGBO(0, 0, 250, 240),
    title: Center(
        child: Text(
          '𝕥𝕒𝕟𝕘𝕝𝕖',
          style: TextStyle(
            fontSize: 30,
          )
        ),
    ),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      )
  );
}

TextStyle simpleTextSTyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}