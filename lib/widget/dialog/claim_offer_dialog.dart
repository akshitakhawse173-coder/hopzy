
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/app_size.dart';
import '../../theme/radius_size.dart';
import '../../theme/strings.dart';
import '../../theme/text_styles.dart';
import '../custom_app_button.dart';
import '../vertical_spacer.dart';

class ClaimOfferDialog extends StatelessWidget {
  final VoidCallback onDoneClick;
  final VoidCallback onSkipClick;

  const ClaimOfferDialog({
    super.key,
    required this.onDoneClick,
    required this.onSkipClick,
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
          width: 296.h,
          height: 305.h,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
                  "assets/images/image_claim_offer.png",
                ), // Your image here
                fit: BoxFit.fitHeight),
            borderRadius: BorderRadius.circular(RadiusSize.radiusSize10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(Strings.getFreeRecharge.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold700(color: AppColors.blackColor, fontSize: AppSize.fontSize28)),
              Text(Strings.claimOfferDescription,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular400(color: AppColors.blackColor, fontSize: AppSize.fontSize12)),
              CustomAppButton(
                  rightMargin: 8,
                  leftMargin: 8,
                  bottomMargin: 4,
                  topMargin: 14,
                  title: Strings.claimNow,
                  textColor: AppColors.whiteColor,
                  bgColor: AppColors.blackColor,
                  onButtonTap: onDoneClick,
                  isDisable: false),
              GestureDetector(
                onTap: onSkipClick,
                child: Text(Strings.skipNow,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.medium500(color: AppColors.blackColor, fontSize: AppSize.fontSize10)),
              ),
              VerticalSpacer(height: 8.h)
            ],
          ),
        ),
      ),
    );
  }
}
