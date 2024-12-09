import 'package:contacts/app/data/enums/sheet_type.dart';
import 'package:contacts/app/widgets/sheets/bottom_sheet_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../themes/colors.dart';
import '../../../themes/texts.dart';

class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet(
      {super.key,
      this.pickCamera,
      this.pickGallery,
      this.patcher}
      );

  final Future<void> Function()? pickCamera;
  final Future<void> Function()? pickGallery;
  final Future<void> Function()? patcher;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BottomSheetDecoration(SheetType.photo).boxDecoration,
        height: 252.h,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
            child: _photoColumn(context)
        )
    );
  }

  Widget _photoColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _button(context, "Camera"),
        SizedBox(height: 15.h),
        _button(context, "Gallery"),
        SizedBox(height: 15.h),
        _button(context, "Cancel")
      ],
    );
  }

  Widget _button(BuildContext context, String text){
    return InkWell(
      onTap: () async {
        if(text == "Camera") {
          await pickCamera!();
          if(patcher!=null) {
            await patcher!();
          }
        }
        if(text == "Gallery") {
          await pickGallery!();
          if(patcher!=null) {
            await patcher!();
          }
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(text == "Camera") ...[
                Icon(CupertinoIcons.camera, size: 24.h),
                SizedBox(width: 15.w)
              ],

              if(text == "Gallery") ...[
                Icon(CupertinoIcons.photo, size: 24.h),
                SizedBox(width: 15.w)
              ],
              Text(text, style: textTheme.headlineLarge!.copyWith(color: text == "Cancel" ? blue : titleTextColor)),
            ],
          )
      ),
    );
  }
}
