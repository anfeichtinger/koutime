import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Colors from Tailwind CSS (v3.0) - June 2022
///
/// https://tailwindcss.com/docs/customizing-colors

const int _primaryColor = 0xFF6366F1;
const MaterialColor primarySwatch = MaterialColor(_primaryColor, <int, Color>{
  50: Color(0xFFEEF2FF), // indigo-50
  100: Color(0xFFE0E7FF), // indigo-100
  200: Color(0xFFC7D2FE), // indigo-200
  300: Color(0xFFA5B4FC), // indigo-300
  400: Color(0xFF818CF8), // indigo-400
  500: Color(_primaryColor), // indigo-500
  600: Color(0xFF4F46E5), // indigo-600
  700: Color(0xFF4338CA), // indigo-700
  800: Color(0xFF3730A3), // indigo-800
  900: Color(0xFF312E81), // indigo-900
});

const int _textColor = 0xFF64748B;
const MaterialColor textSwatch = MaterialColor(_textColor, <int, Color>{
  50: Color(0xFFF8FAFC), // slate-50
  100: Color(0xFFF1F5F9), // slate-100
  200: Color(0xFFE2E8F0), // slate-200
  300: Color(0xFFCBD5E1), // slate-300
  400: Color(0xFF94A3B8), // slate-400
  500: Color(_textColor), // slate-500
  600: Color(0xFF475569), // slate-600
  700: Color(0xFF334155), // slate-700
  800: Color(0xFF1E293B), // slate-800
  900: Color(0xFF0F172A), // slate-900
});

final ThemeData lightTheme = ThemeData(
  primarySwatch: primarySwatch,
  brightness: Brightness.light,
  scaffoldBackgroundColor: textSwatch.shade200,
  backgroundColor: textSwatch.shade200,
  cardColor: const Color(0xFFFAFAFA), // neutral-50
  bottomAppBarColor: Colors.white,
  dividerColor: const Color(0x1C000000),
  highlightColor: textSwatch.shade100,
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    headline1: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.w300,
      fontFamily: 'Nunito',
      fontSize: 98.sp,
    ),
    headline2: TextStyle(
      color: textSwatch.shade600,
      fontWeight: FontWeight.w300,
      fontFamily: 'Nunito',
      fontSize: 62.sp,
    ),
    headline3: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 50.sp,
    ),
    headline4: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 36.sp,
    ),
    headline5: TextStyle(
      color: textSwatch.shade600,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 26.sp,
    ),
    headline6: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 22.sp,
    ),
    subtitle1: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 18.sp,
    ),
    subtitle2: TextStyle(
      color: textSwatch.shade600,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 16.sp,
    ),
    bodyText1: TextStyle(
      color: textSwatch.shade700,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 18.sp,
    ),
    bodyText2: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 16.sp,
    ),
    button: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 16.sp,
    ),
    caption: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 14.sp,
    ),
    overline: TextStyle(
      color: textSwatch.shade500,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 12.sp,
    ),
  ),
);

final ThemeData darkTheme = lightTheme.copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF18181B),  // zinc-900
  backgroundColor: const Color(0xFF18181B),  // zinc-900
  cardColor: const Color(0xFF262626),  // neutral-800
  bottomAppBarColor: const Color(0xFF27272A),  // zinc-800
  dialogBackgroundColor: const Color(0xFF262626),  // neutral-800
  dividerColor: const Color(0x1CFFFFFF),
  highlightColor: const Color(0xFF3F3F46),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.w300,
      fontFamily: 'Nunito',
      fontSize: 98.sp,
    ),
    headline2: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.w300,
      fontFamily: 'Nunito',
      fontSize: 60.sp,
    ),
    headline3: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 50.sp,
    ),
    headline4: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 36.sp,
    ),
    headline5: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 26.sp,
    ),
    headline6: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 22.sp,
    ),
    subtitle1: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 18.sp,
    ),
    subtitle2: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 16.sp,
    ),
    bodyText1: TextStyle(
      color: textSwatch.shade300,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 18.sp,
    ),
    bodyText2: TextStyle(
      color: textSwatch.shade200,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 16.sp,
    ),
    button: TextStyle(
      color: textSwatch.shade400,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 16.sp,
    ),
    caption: TextStyle(
      color: textSwatch.shade400,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 14.sp,
    ),
    overline: TextStyle(
      color: textSwatch.shade400,
      fontWeight: FontWeight.normal,
      fontFamily: 'Nunito',
      fontSize: 12.sp,
    ),
  ),
);
