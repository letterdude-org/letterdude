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
