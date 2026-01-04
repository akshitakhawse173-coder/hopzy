import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import '../../theme/app_color.dart';
import '../../theme/app_size.dart';
import '../../theme/radius_size.dart';
import '../../theme/strings.dart';
import '../../theme/text_styles.dart';
import '../horizontal_spacer.dart';
import '../vertical_spacer.dart';

class ClaimSuccessDialog extends StatelessWidget {
  const ClaimSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        insetPadding: EdgeInsets.zero, // Removes default dialog padding
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusSize.radiusSize10)),
        child: Container(
          margin: EdgeInsets.zero,
          width: ScreenUtil().screenWidth - 15.w,
          height: 290.h,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 45.r,
                    height: 45.r,
                    decoration: BoxDecoration(color: AppColors.cF7F7F7, borderRadius: BorderRadius.circular(RadiusSize.radiusSize10)),
                    child: Padding(
                      padding: REdgeInsets.all(12.0),
                      child: Image.asset("assets/icons/icon_close_2.png"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/image_congratulations.png",
                      height: 65.h,
                      width: 65.w,
                      fit: BoxFit.contain,
                    ),
                    VerticalSpacer(height: 20.h),
                    Text(Strings.congratulations,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBold600(color: AppColors.blackColor, fontSize: AppSize.fontSize24)),
                    Text(Strings.freeRechargeForBothWalkRide,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.regular400(color: AppColors.blackColor, fontSize: AppSize.fontSize14)),
                    VerticalSpacer(height: 26.h),
                    Row(
                      children: [
                        buildRowText(title: Strings.task, value: '01'),
                        HorizontalSpacer(width: 25.w),
                        buildRowText(title: Strings.task, value: '01')
                      ],
                    ),
                    Row(
                      children: [
                        buildRowText(title: Strings.time, value: '15 mins'),
                        HorizontalSpacer(width: 25.w),
                        buildRowText(title: Strings.time, value: '15 mins')
                      ],
                    ),
                    Row(
                      children: [
                        buildRowText(title: Strings.distance, value: '2.5 KM'),
                        HorizontalSpacer(width: 25.w),
                        buildRowText(title: Strings.distance, value: '1.5 KM')
                      ],
                    ),
                    VerticalSpacer(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text("(${Constants.serviceType1})",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.medium500(color: AppColors.blackColor, fontSize: AppSize.fontSize14)),
                        ),
                        Expanded(
                          child: Text("(${Constants.serviceType2})",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.medium500(color: AppColors.blackColor, fontSize: AppSize.fontSize14)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildRowText({required String title, required String value}) {
  return Expanded(
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title, style: AppTextStyle.regular400(color: AppColors.blackColor, fontSize: AppSize.fontSize16)),
          TextSpan(
            text: ": ",
            style: AppTextStyle.regular400(color: AppColors.blackColor, fontSize: AppSize.fontSize16),
          ),
          TextSpan(
            text: value,
            style: AppTextStyle.semiBold600(color: AppColors.blackColor, fontSize: AppSize.fontSize16),
          ),
        ],
      ),
    ),
  );
}
