
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/app_size.dart';
import '../../theme/radius_size.dart';
import '../../theme/text_styles.dart';
import '../vertical_spacer.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onCloseClick;
  final String? icon;
  final String title;
  final String subTitle;
  final double? size;

  const SuccessDialog({super.key, required this.onCloseClick, this.icon, required this.title, this.subTitle = "", this.size});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusSize.radiusSize28)),
      child: Padding(
        padding: REdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(alignment: Alignment.centerRight, child: InkWell(onTap: onCloseClick, child: const Icon(Icons.close_rounded))),
            Image.asset(icon ?? "assets/icons/icon_success_mark.png", height: size ?? 100.r, width: 100.r),
            VerticalSpacer(height: 20.h),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium500().copyWith(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize16),
            ),
            Visibility(
              visible: subTitle.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.medium500().copyWith(color: AppColors.detailsTextColor, fontSize: AppSize.fontSize12),
                ),
              ),
            ),
            VerticalSpacer(height: 25.h),
          ],
        ),
      ),
    );
  }
}
