import 'dart:math';
import 'package:flutter/material.dart';

enum FetchState {
  None,
  Pending,
  Success,
  PermissionError,
}

String formatPhoneNumber(String rawPhoneNumber) {
  if (rawPhoneNumber.length == 10) {
    return '${rawPhoneNumber.substring(0, 3)}-${rawPhoneNumber.substring(3, 6)}-${rawPhoneNumber.substring(6)}';
  }
  if (rawPhoneNumber.length == 11) {
    return '${rawPhoneNumber.substring(0, 3)}-${rawPhoneNumber.substring(3, 7)}-${rawPhoneNumber.substring(7)}';
  }
  return rawPhoneNumber;
}

Color getRandomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
