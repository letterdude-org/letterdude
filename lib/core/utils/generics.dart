import 'package:flutter/material.dart';

Color getResponseStatusColor(int statusCode) {
  if (statusCode >= 200 && statusCode < 300) {
    return Colors.green;
  }
  if (statusCode >= 300 && statusCode < 400) {
    return Colors.orange;
  }
  if (statusCode >= 400) {
    return Colors.red;
  }
  return Colors.grey;
}

String stringifyBytes(int bytes) {
  if (bytes < 1024) {
    return '$bytes Bytes';
  }
  return '${(bytes / 1024).toStringAsFixed(2)} KB';
}

String stringifyMilliseconds(int milliseconds) {
  if (milliseconds == 0) {
    return '0 ms';
  }

  final duration = Duration(milliseconds: milliseconds);

  // Only calculate hours, minutes, seconds and milliseconds
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;
  final ms = duration.inMilliseconds % 1000;

  String result = '';

  if (hours > 0) result += '$hours h ';
  if (minutes > 0) result += '$minutes m ';
  if (seconds > 0) result += '$seconds s ';
  if (ms > 0) result += '$ms ms';

  return result.trim();
}
