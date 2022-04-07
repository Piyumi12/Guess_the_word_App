import 'package:flutter/material.dart';

const Color correct = Color(0xFF32AB58);
const Color incorrect = Color(0xFFAB3232);
const Color neutral = Color(0xFFE7E7E7);
const Color background = Color(0xFF1A3464);
const grey2 = Color(0xFF6D6D6D);

enum EditMode {
  ADD,
  UPDATE,
}

var shadow = [
  BoxShadow(
    color: Colors.grey[300],
    blurRadius: 30,
    offset: Offset(0, 10),
  )
];