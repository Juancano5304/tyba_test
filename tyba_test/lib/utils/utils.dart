import 'dart:math' as math;

import 'package:flutter/material.dart';

Color getRandomColor() {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(1.0);
}

String getInitials(String universityName) {
  String initials = '';
  final List<String> names = universityName.split(' ');
  const int numWords = 2;

  for (int i = 0; i < numWords; i++) {
    initials += names[i][0];
  }
  return initials;
}
