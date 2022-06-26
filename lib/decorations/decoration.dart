import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quote_app/decorations/colors.dart';

Random random = Random();
BorderRadius defaultRadius = BorderRadius.circular(15);
BoxShadow shadow = BoxShadow(
  color: scaffoldColor,
  blurRadius: 30,
  spreadRadius: 10,
);
EdgeInsets defaultPadding = const EdgeInsets.all(10);

BoxDecoration giveDecoration(Color color, Color shadow) {
  return BoxDecoration(color: color, borderRadius: defaultRadius, boxShadow: [
    BoxShadow(
      color: shadow,
      blurRadius: 20,
      spreadRadius: 15,
    ),
  ]);
}

double kPadding = 25;

LinearGradient pickRandom() {
  return gradients.elementAt(random.nextInt(gradients.length - 1));
}

List<LinearGradient> gradients = [
  LinearGradient(
    colors: [
      HexColor('#A1FFCE'),
      HexColor('#FAFFD1'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#BE93C5'),
      HexColor('#7BC6CC'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#bdc3c7'),
      HexColor('#2c3e50'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#ffd89b'),
      HexColor('#19547b'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#fceabb'),
      HexColor('#f8b500'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#f79d00'),
      HexColor('#64f38c'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#56ab2f'),
      HexColor('#a8e063'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [
      HexColor('#F00000'),
      HexColor('#DC281E'),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
];
