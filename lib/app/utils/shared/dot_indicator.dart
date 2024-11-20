import 'package:flutter/material.dart';

dotIndicator(double width, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3),
    width: width,
    height: 10,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
