import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/colors.dart';
import '../../themes/texts.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    this.hintText,
    this.onChanged,
    this.controller,
    super.key,
  });

  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      onChanged: onChanged,
      controller: controller,
      cursorWidth: 1,
      style: textTheme.headlineMedium,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 9.h,
          horizontal: 12.w,
        ),
        isDense: true,
        hintText: hintText,
        hintStyle: textTheme.headlineMedium!.copyWith(color: grey),
        prefixIconConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
          ),
          child: Icon(
            CupertinoIcons.search,
            color: grey,
            size: 21.h,
          ),
        ),
      ),
    );
  }
}
