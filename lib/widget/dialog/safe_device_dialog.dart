
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/radius_size.dart';
import '../../theme/text_styles.dart';
import '../vertical_spacer.dart';

class SafeDeviceDialog extends StatefulWidget {
  final String title;
  static bool _isDialogShowing = false;

  const SafeDeviceDialog({super.key, required this.title});

  static void show({required BuildContext context, required String title}) {
    if (_isDialogShowing) return;

    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (context) => SafeDeviceDialog(title: title),
    ).then((_) {
      _isDialogShowing = false;
    });
  }

  @override
  State<SafeDeviceDialog> createState() => _SafeDeviceDialogState();
}

class _SafeDeviceDialogState extends State<SafeDeviceDialog> {
  @override
  void dispose() {
    SafeDeviceDialog._isDialogShowing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent closing with back button
        return false;
      },
      child: Dialog(
        backgroundColor: AppColors.backgroundColor,
        insetPadding: EdgeInsets.symmetric(horizontal: 14.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSize.radiusSize8),
        ),
        child: Padding(
          padding: REdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Security Alert",
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBold600(fontSize: 16.w),
              ),
              VerticalSpacer(height: 30.h),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: AppTextStyle.regular400(fontSize: 13.w).copyWith(height: 1.5),
              ),
              VerticalSpacer(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
