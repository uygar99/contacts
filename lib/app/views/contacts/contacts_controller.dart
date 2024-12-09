import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/enums/operation_type.dart';
import '../../data/models/user.dart';
import '../../services/user_service.dart';
import '../../widgets/sheets/bottom_sheet.dart';
import '../../widgets/sheets/success_sheet.dart';

class ContactsController extends GetxController {
  RxList<User> users = <User>[].obs;
  final PagingController<int, User> pagingController =
  PagingController(firstPageKey: 1);
  TextEditingController searchBoxController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rxn<XFile?> imageFile = Rxn<XFile?>();
  Rxn<User> selectedUser = Rxn<User>();
  RxString imageUrl = "".obs;
  final ImagePicker picker = ImagePicker();
  RxBool isLoading = true.obs;
  RxString userId = "".obs;
  Timer? searchBounceTimer;

  @override
  void onInit() async {
    await loadData(pageKey: 1);
    pagingController.addPageRequestListener((pageKey) async {
      await loadData(pageKey: pageKey, search: searchBoxController.text);
    });
    isLoading(false);
    super.onInit();
  }

  Future<void> pickCamera() async {
    isLoading(true);
    imageFile.value = await picker.pickImage(source: ImageSource.camera);
    Get.back();
    imageUrl.value = await UserService.to.postPhoto(imageFile.value);
    Get.back();
    isLoading(false);
  }

  Future<void> pickGallery() async {
    isLoading(true);
    imageFile.value = await picker.pickImage(source: ImageSource.gallery);
    Get.back();
    imageUrl.value = await UserService.to.postPhoto(imageFile.value);
    isLoading(false);
  }

  Future<void> loadData({String? search, int? pageKey = 1}) async {
    var response = await UserService.to.getUserList(
      search: search,
      take: 15,
      skip: (pageKey!-1) * 15,
    );
    if (response.success == true) {
      var userList = response.data.users!;
      users(userList);
      if (userList.isEmpty) {
        pagingController.appendLastPage(userList);
      } else {
        pagingController.appendPage(userList, pageKey+1);
      }
    }
  }

  Future<void> add() async {
    var response = await UserService.to.addUser(firstNameController.text, lastNameController.text, phoneController.text, imageUrl.value);
    Get.back();
    pagingController.refresh();
  }

  Future<void> delete() async {
    var response = await UserService.to.deleteUser(userId.value);
    Get.back();
    Get.back();
    Get.back();
    pagingController.refresh();
  }

  Future<void> patch() async {
    var response = await UserService.to.patchUser(userId.value, firstNameController.text, lastNameController.text, phoneController.text, imageUrl.value);
    selectedUser.value = response.data;
    pagingController.refresh();
  }

  void showBottom({required BuildContext context, User? user, required OperationType type}) async {
    if(type != OperationType.detail){
      firstNameController.text = "";
      lastNameController.text = "";
      phoneController.text = "";
    }
    if(type == OperationType.detail){
      firstNameController.text = user!.firstName ?? "";
      lastNameController.text = user.lastName ?? "";
      phoneController.text = user.phoneNumber ?? "";
    }
    if(user != null) userId.value = user.id!;
    selectedUser.value = user;
    Get.bottomSheet<dynamic>(
        UserBottomSheet(
          isLoading: isLoading,
              type: type,
              user: selectedUser,
              image: imageFile,
              imageUrl: imageUrl,
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              phoneController: phoneController,
              pickCamera: pickCamera,
              pickGallery: pickGallery,
              patcher: patch,
              deleter: delete,
              adder: add,
        ),
      isScrollControlled: true, barrierColor: Colors.transparent
    );
  }

  void successOpen({required BuildContext context, required OperationType type}){
    Get.bottomSheet(
        SuccessSheet(type: type), isScrollControlled: true, persistent: false, barrierColor: Colors.transparent);
  }

  void search(String? value) async {
    if (value == null) {
      return;
    }
    if (searchBounceTimer != null) {
      searchBounceTimer?.cancel();
    }
    searchBounceTimer = Timer(
      const Duration(milliseconds: 600),
          () async {
        pagingController.refresh();
      },
    );
  }
}