import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/radius_size.dart';
import '../../theme/strings.dart';
import '../custom_app_button.dart';

class CameraPermissionDialog extends StatefulWidget {
  const CameraPermissionDialog({super.key});

  @override
  State<CameraPermissionDialog> createState() => _CameraPermissionDialogState();
}

class _CameraPermissionDialogState extends State<CameraPermissionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 14.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusSize.radiusSize8)),
      child: Padding(
        padding: REdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: CustomAppButton(
                      title: Strings.cancel,
                      isShowBorder: true,
                      borderColor: AppColors.editTextBorderColor,
                      topMargin: 25,
                      bottomMargin: 8,
                      leftMargin: 0,
                      rightMargin: 8,
                      onButtonTap: () {
                        Navigator.pop(context);
                      },
                      isDisable: false),
                ),
                Expanded(
                    child: CustomAppButton(
                  title: "Open Settings",
                  onButtonTap: () {
                    Navigator.pop(context);
                  },
                  isDisable: false,
                  topMargin: 25,
                  bottomMargin: 8,
                  rightMargin: 0,
                  leftMargin: 8,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
