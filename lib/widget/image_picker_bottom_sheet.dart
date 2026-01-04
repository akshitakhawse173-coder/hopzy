import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/radius_size.dart';
import '../theme/strings.dart';
import '../theme/text_styles.dart';
import '../timelines/common_functions.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback galleryCallBack;
  final VoidCallback cameraCallBack;

  const ImagePickerBottomSheet({
    super.key,
    required this.title,
    required this.galleryCallBack,
    required this.cameraCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 180.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 18.w, right: 18.w, bottom: 18.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyle.medium500(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.cancel, color: AppColors.headlineTextColor),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                Strings.gallery,
                style: AppTextStyle.medium500(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize14),
              ),
              leading: const Icon(Icons.image),
              onTap: galleryCallBack,
            ),
            ListTile(
              title: Text(
                Strings.camera,
                style: AppTextStyle.medium500(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize14),
              ),
              leading: const Icon(Icons.camera),
              onTap: () async {
                // Check the current permission status
                CommonFunctions.handleCameraPermission(
                    context: context,
                    onPermissionGranted: () {
                      cameraCallBack();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, String title, VoidCallback galleryCallBack, VoidCallback cameraCallBack) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(RadiusSize.radiusSize10), topRight: Radius.circular(RadiusSize.radiusSize10))),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(title: title, galleryCallBack: galleryCallBack, cameraCallBack: cameraCallBack);
      },
    );
  }
}
