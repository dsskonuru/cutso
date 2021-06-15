import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const kOrange = Color(0xFFff8800);
const kOrangeLight = Color(0xFFffb944);
const kOrangeDark = Color(0xFFc55900);

const kCream = Color(0xFFf8dda4);
const kCreamLight = Color(0xFFffffd6);
const kCreamDark = Color(0xFFc4ab75);

const kErrorRed = Color(0xFFC5032B);

final buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(kOrange),
);

ThemeData themeData(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        // Headline
        headline6: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20.sp,
            letterSpacing: 0.15.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700 // Medium
            ),
        // Subtitle
        subtitle1: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16.sp,
          letterSpacing: 0.15.sp,
          fontStyle: FontStyle.normal,
        ),
        // Body
        bodyText2: TextStyle(
          fontFamily: 'PT Sans',
          fontSize: 15.sp,
          letterSpacing: 0.25.sp,
          fontStyle: FontStyle.normal,
        ),
        // Button
        button: TextStyle(
          // ALL CAPS
          fontFamily: 'PT Sans',
          fontSize: 14.sp,
          letterSpacing: 1.25.sp,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700, // Medium
        ),
        caption: TextStyle(
          fontFamily: 'PT Sans',
          fontSize: 13.sp,
          letterSpacing: 0.4.sp,
          fontStyle: FontStyle.normal,
        ),
        overline: TextStyle(
          // ALL CAPS
          fontFamily: 'PT Sans',
          fontSize: 11.sp,
          letterSpacing: 1.5.sp,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
