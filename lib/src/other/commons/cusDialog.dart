import 'package:flutter/material.dart';

class CusDialog {
  static showPopUpDialog(
      BuildContext context, String title, Widget content, List<Widget> action) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: content,
            actions: action,
          );
        });
  }
}
