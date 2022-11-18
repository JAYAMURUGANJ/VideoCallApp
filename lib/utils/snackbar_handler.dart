import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar snackBar(String content) {
    return SnackBar(content: Text(content));
  }

  // --------------------------- Scheduled Meetings ---------------------------
  static joinMeetingTooEarly() {
    return snackBar(
        'The video meeting has not started yet. Please join at the scheduled time.');
  }

  static appNotFound() {
    return snackBar('WhatsApp is not installed on the device');
  }

  static pleaseFillData() {
    return snackBar('Please fill moto & mobile number!');
  }
}
