import 'package:contacts/themes/colors.dart';
import 'package:contacts/themes/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/enums/operation_type.dart';
import '../../data/models/user.dart';
import '../../widgets/user_image.dart';
import '../../widgets/search_box.dart';
import '../../widgets/user_item.dart';
import 'contacts_controller.dart';


class ContactsView extends GetView<ContactsController> {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.isTrue ?
          const Center(child: CircularProgressIndicator())
          : Container(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              _title(context),
              SizedBox(height: 11.h),
              _searchBox(),
              _contactList()
            ],
          ),
        ),
    ));
  }

  Widget _title(BuildContext context){
    return Row(
      children: [
        Text("Contacts", style: textTheme.headlineLarge),
        const Spacer(),
        _addButton(context)
      ],
    );
  }

  Widget _addButton(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 4.h),
        InkWell(
          onTap: () {
            controller.imageUrl.value = "";
            controller.showBottom(context: context, type: OperationType.add);
          },
            child: Icon(CupertinoIcons.add_circled_solid, color: blue, size: 24.h)
        ),
      ],
    );
  }

  Widget _searchBox(){
    return SearchBox(
      hintText: "Search by name",
      controller: controller.searchBoxController,
      onChanged: (value) => controller.search(value),
    );
  }

  Widget _emptyContacts(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const UserImage(size: 60),
        SizedBox(height: 7.h),
        Text(
            'No Contacts',
            style: textTheme.headlineLarge
        ),
        SizedBox(height: 7.h),
        Text(
            'Contacts you’ve added will appear here.',
            style: textTheme.headlineMedium
        ),
        SizedBox(height: 7.h),
        InkWell(
          onTap: () {
    controller.imageUrl.value = "";
            controller.showBottom(context: context, type: OperationType.add);
          },
          child: Text(
              'Create New Contact',
              style: textTheme.headlineMedium!.copyWith(color: blue)
          ),
        ),
      ],
    );
  }

  Widget _contactList(){
    return Expanded(
      child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
        ),
        child: PagedListView<int, User>(
          padding: const EdgeInsets.all(0),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<User>(
            noItemsFoundIndicatorBuilder: (context) {
              return _emptyContacts(context);
            },
            noMoreItemsIndicatorBuilder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 20.w,
                ),
                child: const Text(
                  "These were all the records.",
                  textAlign: TextAlign.center,
                ),
              );
            },
            itemBuilder: (context, user, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [],
                ),
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    //Text(user.firstName!),
                    SizedBox(height: 20.h),
                    UserItem(user: user, onTap: () {
                      controller.imageUrl.value = "";
                      controller.showBottom(context: context, user: user, type: OperationType.detail);
                      })
                  ],
                ),
              );
            },
          ),
        )
      ),
    );
  }
}