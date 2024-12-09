import 'package:contacts/app/data/enums/operation_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../themes/texts.dart';
import '../../data/enums/sheet_type.dart';
import 'bottom_sheet_decoration.dart';

class SuccessSheet extends StatelessWidget {
  const SuccessSheet(
      {super.key,
        required this.type}
      );
  final OperationType type;

@override
  Widget build(BuildContext context) {
  return Container(
      decoration: BottomSheetDecoration(SheetType.success).boxDecoration,
      height: 84.h,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
          child: _successRow()
      )
  );
}
Widget _successRow() {
  return Row(
    children: [
      Icon(CupertinoIcons.checkmark_seal_fill, color: green, size: 24.h),
      SizedBox(width: 15.w),
      Text(type == OperationType.add ? "User added !" : type == OperationType.patch ? "Changes have been applied!": "Account deleted!", style: textTheme.headlineMedium!.copyWith(color: green))
    ],
  );
}
}
