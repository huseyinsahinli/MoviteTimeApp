import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogBox {
  static AlertDialog warningAlertBox(
    String message,
  ) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      backgroundColor: Colors.red,
      shape: const StadiumBorder(),
      content: SingleChildScrollView(
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  static AlertDialog successfulAlertBox(
    String message,
  ) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      backgroundColor: Colors.green[400],
      shape: const StadiumBorder(),
      content: SingleChildScrollView(
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  static getAlertDialog(context, AlertDialog alertDialog, Timer timer) {
    return showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          timer = Timer(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return alertDialog;
        }).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }
}
