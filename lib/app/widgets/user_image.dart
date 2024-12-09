import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../data/models/user.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.size, this.url, this.user});
  final int size;
  final String? url;
  final User? user;

  @override
  Widget build(BuildContext context) {
    if(url != null && url! != ""){
      return
        CachedNetworkImage(
          imageUrl: url!,
          imageBuilder: (context, imageProvider) => Container(
            width: size.h,
            height: size.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            CupertinoIcons.person_crop_circle_fill,
            color: grey,
            size: size.h,
          ),
        );
    }

    if(user != null && user!.profileImageUrl != null && user!.profileImageUrl != "") {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          width: size.h,
          height: size.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      imageUrl: user!.profileImageUrl!,
      errorWidget: (context, url, error) => Icon(
        CupertinoIcons.person_crop_circle_fill,
        color: grey,
        size: size.h,
      ),
      );
    }
    return
      Icon(
        CupertinoIcons.person_crop_circle_fill,
        color: grey,
        size: size.h,
      );
  }
}
