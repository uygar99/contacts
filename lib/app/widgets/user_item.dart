import 'package:contacts/app/widgets/user_image.dart';
import 'package:contacts/themes/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../data/models/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    required this.user,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final User user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(
          vertical: 13.h,
          horizontal: 20.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                UserImage(size: 34, user: user)
              ],
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                _phone()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _phone() {
    return
      Expanded(
          child: Text(
              "${user.phoneNumber}" ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineMedium!.copyWith(color: grey)
          )
      );
  }

  Widget _title() {
    return
        Expanded(
          child: Text(
            "${user.firstName} ${user.lastName}" ,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineMedium
          )
    );
  }
}