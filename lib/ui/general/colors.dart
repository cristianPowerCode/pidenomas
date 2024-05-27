import 'dart:ui';
import 'package:flutter/material.dart';

const Color kBrandPrimaryColor2 = Color(0xff00B53E);
const Color kBrandPrimaryColor1 = Color(0xff40D891);
const Color kBrandSecundaryColor1 = Color(0xffFECC34);
const Color kBrandSecundaryColor2 = Color(0xffFFA800);
const Color kErrorColor = Colors.redAccent;

const Gradient degradado1 = LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [kBrandPrimaryColor1, kBrandPrimaryColor2],
);

const Gradient degradado2 = LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [kBrandSecundaryColor1, kBrandSecundaryColor2],
);