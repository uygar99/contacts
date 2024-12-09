import 'package:flutter/material.dart';

const buttonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w500,
);

final primaryButtonStyle = ButtonStyle(
  splashFactory: NoSplash.splashFactory,
  elevation: const MaterialStatePropertyAll(0),
  fixedSize: const MaterialStatePropertyAll(Size(double.infinity, 50)),
  padding: const MaterialStatePropertyAll(
    EdgeInsets.symmetric(
      horizontal: 16,
    ),
  ),
  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
  foregroundColor: const MaterialStatePropertyAll(Colors.white),
  textStyle: MaterialStateTextStyle.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return buttonTextStyle.copyWith(
        color: Colors.white,
      );
    }
    return buttonTextStyle;
  }),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      side: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(0xFF202020);
    }
    if (states.contains(MaterialState.hovered)) {
      return const Color(0xFF202020);
    }
    if (states.contains(MaterialState.disabled)) {
      return const Color(0xFFD7D8DD);
    }
    return const Color(0xFF000000);
  }),
);

final secondaryButtonStyle = primaryButtonStyle.copyWith(
  backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(0xFFA6A8AA);
    }
    if (states.contains(MaterialState.hovered)) {
      return const Color(0xFF898D91);
    }
    if (states.contains(MaterialState.disabled)) {
      return const Color(0xFF97989D);
    }
    return const Color(0xFFA6A8AA);
  }),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return Colors.white;
    }
    return const Color(0xFF585F68);
  }),
  textStyle: MaterialStateTextStyle.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return buttonTextStyle;
    }
    return buttonTextStyle.copyWith(
      color: const Color(0xFF585F68),
    );
  }),
);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: primaryButtonStyle,
);