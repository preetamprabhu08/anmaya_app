import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  static void error(String message, {ToastGravity gravity = ToastGravity.BOTTOM, int durationSeconds = 3}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: durationSeconds == 2 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void warning(String message, {ToastGravity gravity = ToastGravity.BOTTOM, int durationSeconds = 3}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: durationSeconds == 2 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: Colors.orange.shade800,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void info(String message, {ToastGravity gravity = ToastGravity.BOTTOM, int durationSeconds = 2}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: durationSeconds == 2 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: Colors.blue.shade600,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
