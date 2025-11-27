import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class AppTextStyles {
  static TextStyle headline(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      fontSize: isDesktop ? 24 : 20,
    );
  }

  static TextStyle title(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: isDesktop ? 18 : 16,
    );
  }

  static TextStyle body(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: isDesktop ? 16 : 14,
    );
  }

  static TextStyle caption(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: isDesktop ? 13 : 12,
    );
  }
}