import 'package:contacts/app/widgets/sheets/success_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/texts.dart';
import '../../data/enums/operation_type.dart';
import '../../data/enums/sheet_type.dart';
import 'bottom_sheet_decoration.dart';

class SureSheet extends StatelessWidget {
  const SureSheet(
      {super.key,
      required this.deleter}
      );
final Future<void> Function() deleter;


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BottomSheetDecoration(SheetType.sure).boxDecoration,
        height: 241.h,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
            child: _sureColumn(context)
        )
    );
  }
  Widget _sureColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: Text("Delete Account?", style: textTheme.headlineLarge!.copyWith(color: red))),
        SizedBox(height: 25.h),
        _button(context, true),
        SizedBox(height: 15.h),
        _button(context, false)
        ],
    );
  }
  Widget _button(BuildContext context, bool isYes){
    return InkWell(
      onTap: () async {
        if(isYes){
          await deleter();
          successOpen(context: context);
        }
        else {
          Get.back();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
        child: Center(child: Text(isYes ? "Yes" : "No", style: textTheme.headlineLarge,))
      ),
    );
  }

  void successOpen({required BuildContext context}){
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const SuccessSheet(type: OperationType.delete);
        });
  }
}
