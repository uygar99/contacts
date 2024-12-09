import 'package:contacts/app/data/enums/operation_type.dart';
import 'package:contacts/app/widgets/sheets/bottom_sheet_decoration.dart';
import 'package:contacts/app/widgets/user_image.dart';
import 'package:contacts/app/widgets/sheets/photo_source_sheet.dart';
import 'package:contacts/app/widgets/sheets/success_sheet.dart';
import 'package:contacts/app/widgets/sheets/sure_sheet.dart';
import 'package:contacts/themes/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../themes/colors.dart';
import '../../data/enums/sheet_type.dart';
import '../../data/models/user.dart';

class UserBottomSheet extends StatelessWidget {
  const UserBottomSheet({super.key,
    required this.type,
    this.user,
    this.image,
    this.imageUrl,
    this.firstNameController,
    this.lastNameController,
    this.phoneController,
    this.pickCamera,
    this.isLoading,
    this.pickGallery,
    this.adder,
    this.patcher,
    this.deleter,
  });

  final OperationType type;
  final Rxn<User>? user;
  final RxBool? isLoading;
  final Rxn<XFile?>? image;
  final RxString? imageUrl;
  final TextEditingController? firstNameController;
  final TextEditingController? lastNameController;
  final TextEditingController? phoneController;
  final Future<void> Function()? pickCamera;
  final Future<void> Function()? pickGallery;
  final Future<void> Function()? adder;
  final Future<void> Function()? patcher;
  final Future<void> Function()? deleter;



  @override
  Widget build(BuildContext context) {
    return Obx(() => (isLoading != null && isLoading!.isTrue) ? const Center(child: CircularProgressIndicator()) :
       Container(
        decoration: type == OperationType.patch ?
        BottomSheetDecoration(SheetType.bottom).boxDecoration :
        BottomSheetDecoration(SheetType.bottom).boxDecoration,
        height: 882.h,
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: type == OperationType.detail ? _detail(context) : type == OperationType.add ? _add(context) : _edit(context)
        )
      ),
    );
  }

  Widget _detail(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titleRow(context),
        SizedBox(height: 40.5.h),
        Obx(() => UserImage(size: 195, user: user!.value, url: imageUrl!.value)),
        SizedBox(height: 10.h),
        InkWell(
            onTap: () async {
              photoSourceOpen(context);
            },
            child: Center(child: Text((user!.value!.profileImageUrl == "" || user!.value!.profileImageUrl == null) && (imageUrl == null || imageUrl!.value == "") ? "Add Photo" : "Change Photo", style: textTheme.headlineMedium))
        ),
        SizedBox(height: 30.h),
        _text(user!.value!.firstName ?? ""),
        SizedBox(height: 15.h),
        const Divider(color: grey),
        SizedBox(height: 15.h),
        _text(user!.value!.lastName ?? ""),
        SizedBox(height: 15.h),
        const Divider(color: grey),
        SizedBox(height: 15.h),
        _text(user!.value!.phoneNumber ?? ""),
        SizedBox(height: 15.h),
        const Divider(color: grey),
        SizedBox(height: 15.h),
        InkWell(
            onTap: () => sureOpen(context),
            child: _text("Delete contact", isDelete: true)
        ),
      ],
    ));
  }

  Widget _add(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titleRow(context),
        SizedBox(height: 40.5.h),
        Obx(() => UserImage(size: 195, url: imageUrl!.value)),
        SizedBox(height: 10.h),
        Obx(() => InkWell(
              onTap: () => photoSourceOpen(context),
              child: Center(child: Text(imageUrl == null || imageUrl!.value == "" ? "Add Photo" : "Change Photo", style: textTheme.headlineMedium))
          ),
        ),
        SizedBox(height: 30.h),
        _textField(firstNameController!, "First name"),
        SizedBox(height: 20.h),
        _textField(lastNameController!, "Last name"),
        SizedBox(height: 20.h),
        _textField(phoneController!, "Phone number"),
      ],
    );
  }

  Widget _edit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titleRow(context),
        SizedBox(height: 40.5.h),
        Obx(() => UserImage(size: 195, user: user!.value, url: imageUrl!.value)),
        SizedBox(height: 10.h),
        Obx(() => InkWell(
              onTap: () => photoSourceOpen(context),
              child: Center(child: Text((user!.value!.profileImageUrl == "" || user!.value!.profileImageUrl == null) && (imageUrl == null || imageUrl!.value == "") ? "Add Photo" : "Change Photo", style: textTheme.headlineMedium))
          ),
        ),
        SizedBox(height: 30.h),
        _textField(firstNameController!, "First name"),
        SizedBox(height: 20.h),
        _textField(lastNameController!, "Last name"),
        SizedBox(height: 20.h),
        _textField(phoneController!, "Phone number"),
      ],
    );
  }

  Widget _text(String text,{bool isDelete = false}){
    return Text(
      text,
      style: textTheme.headlineMedium!.copyWith(color: isDelete ? red : Colors.black),
    );
  }

  Widget _titleRow(BuildContext context){
    return Row(
      children: [
        InkWell(
            onTap: () => Get.back(), child: Text("Cancel", style: textTheme.bodyMedium!.copyWith(color: blue))
        ),
        const Spacer(),
        if(type == OperationType.add) Text("New Contact", style: textTheme.headlineMedium),
        const Spacer(),
        if(type == OperationType.detail)
          InkWell(
            onTap: () async {
              Get.bottomSheet<dynamic>(
                  UserBottomSheet(
                    isLoading: isLoading,
                      type: OperationType.patch,
                      user: user,
                      imageUrl: imageUrl,
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      phoneController: phoneController,
                      patcher: patcher,
                      pickCamera: pickCamera,
                      pickGallery: pickGallery,
                  ),
              isScrollControlled: true,
              barrierColor: Colors.transparent);
                },
              child: Text("Edit", style: textTheme.headlineMedium!.copyWith(color: blue))
          )
        else
          InkWell(
            onTap:() async {
              if(type == OperationType.patch){
                await patcher!();
                successOpen(context: context, type: type);
              }
              else {
                await adder!();
                successOpen(context: context, type: type);

              }
            },
              child: Text("Done", style: textTheme.headlineMedium!.copyWith(color: blue))
          )
      ],
    );
  }

  void successOpen({required BuildContext context, required OperationType type}){
    Get.bottomSheet(SuccessSheet(type: type), isScrollControlled: true, barrierColor: Colors.transparent);
  }

  void sureOpen(BuildContext context){
    Get.bottomSheet(SureSheet(deleter: deleter!), isScrollControlled: true, barrierColor: Colors.transparent);
  }

  void photoSourceOpen(BuildContext context){
    Get.bottomSheet(isScrollControlled: true, PhotoSourceSheet(pickCamera: pickCamera, pickGallery: pickGallery, patcher: type == OperationType.add ? null : patcher), barrierColor: Colors.transparent);
  }

  Widget _textField(TextEditingController controller, String hint){
    return TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: backgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 20.w,
            ),
            isDense: true,
            hintText: hint,
            hintStyle: textTheme.headlineMedium!.copyWith(color: grey),
          ),
    );
  }
}
