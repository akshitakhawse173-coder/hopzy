import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/text_styles.dart';
import '../widget/horizontal_spacer.dart';
import '../widget/vertical_spacer.dart';

class CoachMarkDesc extends StatelessWidget {
  const CoachMarkDesc({
    Key? key,
    required this.text,
    required this.desc,
    required this.itemCount,
    this.skip = " ",
    this.next = "Next",
    this.onSkip,
    this.onNext,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.coachmarkIcon,
    this.coachmarkIconHeight,
    this.iconAtBottom = false,
    this.isListItems = false,
    this.listItemsImages,
    this.containerHeight,
    this.isHand = true,
    this.isAccounts = false,
    this.totalItemCount = 18,
    // required this.alignmentIcon,
    // required this.alignmentContainer,
  }) : super(key: key);

  final String text;
  final String desc;
  final int itemCount;
  final int totalItemCount;
  final String? skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final Widget? coachmarkIcon;
  final double? coachmarkIconHeight;
  final bool? iconAtBottom;
  final bool isListItems;
  final String? listItemsImages;
  final double? containerHeight;
  final bool isHand;
  final bool isAccounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isHand) ...[
          SizedBox(
            width: 100.w,
            height: coachmarkIconHeight ?? 7.h,
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  right: right,
                  top: top,
                  bottom: bottom,
                  child: coachmarkIcon ??
                      SvgPicture.asset(
                        "AssetUtils.coachmarkHand",
                        width: 50.r,
                        height: 50.r,
                        fit: BoxFit.contain,
                      ),
                ),
              ],
            ),
          ),
        ] else ...[
          const SizedBox(),
        ],

        // if hand is removed

        if (!isHand) ...[VerticalSpacer(height: 15.h)],

        Container(
          // height: isListItems ? ch(168) : ch(154),
          height: containerHeight ?? 154.h,
          width: 327.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.c101010),
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: AppTextStyle.bold700(color: AppColors.whiteColor, fontSize: AppSize.fontSize14),
                    ),
                    Text(
                      '$itemCount/$totalItemCount',
                      style: AppTextStyle.bold700(color: AppColors.c8B8B8B, fontSize: AppSize.fontSize14),
                    )
                  ],
                ),
                if (isListItems) ...[VerticalSpacer(height: 16.h)] else ...[VerticalSpacer(height: 5.h)],
                if (isListItems) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        listItemsImages!,
                        width: 28.w,
                        height: 25.h,
                        fit: BoxFit.contain,
                        color: AppColors.c00F659,
                      ),
                      HorizontalSpacer(width: 17.w),
                      Expanded(
                          child: Text(
                        desc,
                        style: AppTextStyle.medium500(color: AppColors.cFEFEFE, fontSize: AppSize.fontSize14),
                      )),
                    ],
                  ),
                ] else ...[
                  Text(
                    desc,
                    style: AppTextStyle.medium500(color: AppColors.cFEFEFE, fontSize: AppSize.fontSize14),
                  )
                ],
                VerticalSpacer(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: onSkip,
                        child: Text(
                          "dismiss",
                          style: AppTextStyle.bold700(color: AppColors.whiteColor, fontSize: AppSize.fontSize12)
                              .copyWith(decoration: TextDecoration.underline),
                        )),

                    // * Next Button * //
                    InkWell(
                      onTap: onNext,
                      child: Container(
                          width: 77.h,
                          height: 32.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.whiteColor, width: 1.w),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text(
                            "next",
                            style: AppTextStyle.bold700(color: AppColors.whiteColor, fontSize: AppSize.fontSize13)
                                .copyWith(decoration: TextDecoration.underline),
                          ))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        VerticalSpacer(height: 18.h)
      ],
    );
  }
}
