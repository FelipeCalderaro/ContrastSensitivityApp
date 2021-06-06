import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle callout = GoogleFonts.firaSans(
    fontSize: 27,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle title = GoogleFonts.firaSans(
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle subtitle = GoogleFonts.firaSans(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
  );

  static final TextStyle regular = GoogleFonts.firaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static final TextStyle buttonText = GoogleFonts.firaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
