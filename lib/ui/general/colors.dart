import 'dart:ui';
import 'package:flutter/material.dart';

const Color kBrandPrimaryColor2 = Color(0xff00B53E);
const Color kBrandPrimaryColor1 = Color(0xff40D891);
const Color kBrandSecundaryColor1 = Color(0xffFECC34);
const Color kBrandSecundaryColor2 = Color(0xffFFA800);
const Color kBrandErrorColor = Color(0xffff5252);
const Color kBrandGreyColor = Color(0xff9E9E9E);
const Color kBrandWhiteColor = Color(0xffffffff);

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