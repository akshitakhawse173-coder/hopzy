
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../constants/common_variables.dart';
import '../../theme/app_color.dart';
import '../../theme/app_size.dart';
import '../../theme/radius_size.dart';
import '../../theme/strings.dart';
import '../../theme/text_styles.dart';
import '../custom_app_button.dart';
import '../vertical_spacer.dart';

class FinishTaskDialog extends StatelessWidget {
  final VoidCallback onYesClick;
  final VoidCallback onNoClick;

  const FinishTaskDialog({
    super.key,
    required this.onYesClick,
    required this.onNoClick,
  });

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
          width: 280.h,
          child: Padding(
            padding: REdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(Strings.finishTask.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.semiBold600(color: AppColors.blackColor, fontSize: AppSize.fontSize18)),
                VerticalSpacer(height: 5.h),
                Image.asset("assets/icons/icon_about_us.png", height: 50.r, width: 50.r),
                VerticalSpacer(height: 20.h),
                Text("${Strings.dear} ${HydratedBloc.storage.read(CommonVariables.name) ?? "User"},",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular400(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize14)),
                VerticalSpacer(height: 4.h),
                Text(Strings.finishTaskDesc,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular400(color: AppColors.headlineTextColor, fontSize: AppSize.fontSize14)),
                VerticalSpacer(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomAppButton(
                          rightMargin: 8,
                          leftMargin: 0,
                          bottomMargin: 0,
                          topMargin: 14,
                          title: Strings.no,
                          textColor: AppColors.debitRedColor,
                          isShowBorder: true,
                          borderColor: AppColors.editTextBorderColor,
                          onButtonTap: onNoClick,
                          isDisable: false),
                    ),
                    Expanded(
                      child: CustomAppButton(
                          rightMargin: 0,
                          leftMargin: 8,
                          bottomMargin: 0,
                          topMargin: 14,
                          title: Strings.yes,
                          bgColor: AppColors.creditGreenColor.withOpacity(0.2),
                          textColor: AppColors.creditGreenColor,
                          onButtonTap: onYesClick,
                          isDisable: false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
