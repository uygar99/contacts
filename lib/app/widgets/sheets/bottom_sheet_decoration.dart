import 'package:flutter/material.dart';

import '../../data/enums/sheet_type.dart';

class BottomSheetDecoration {
  final SheetType? type;
  final BoxDecoration boxDecoration;

  BottomSheetDecoration(this.type)
      : boxDecoration = BoxDecoration(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
    boxShadow: type != SheetType.patch
        ? [
      const BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 40.10,
        offset: Offset(0, -6),
        spreadRadius: 0,
      ),
    ]
        : [],
    color: Colors.white,
  );
}
