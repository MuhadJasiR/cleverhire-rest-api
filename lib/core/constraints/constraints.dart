import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kHeight(double height) {
  return SizedBox(height: height);
}

Widget kWidth(double width) {
  return SizedBox(
    width: width,
  );
}

final kMainFont = GoogleFonts.lato(
    fontSize: 55, color: const Color.fromARGB(255, 19, 238, 118));
final kSubFont = GoogleFonts.lato(fontSize: 13);
