import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'snackbar_handler.dart';

// --------------------------- Schedule meeting ---------------------------
bool checkIfTimeInPast(TimeOfDay timeOfDay) {
  double toDouble(TimeOfDay timeOfDay) =>
      timeOfDay.hour + timeOfDay.minute / 60.0;
  if (toDouble(timeOfDay) < toDouble(TimeOfDay.now())) {
    return true;
  } else {
    return false;
  }
}

bool checkIfJoinMeetingTooEarly(
    String date, String time, BuildContext context) {
  DateTime meetingDate = DateFormat('yMMMd').parse(date);
  DateTime meetingTime = DateFormat('jm').parse(time);

  DateTime meetingDateTime = DateTime(meetingDate.year, meetingDate.month,
      meetingDate.day, meetingTime.hour, meetingTime.minute);

  DateTime currentTime = DateTime.now();
  final diffMinutes = currentTime.difference(meetingDateTime).inMinutes;

  if (diffMinutes > -5) {
    return false;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.joinMeetingTooEarly());
    return true;
  }
}
