import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/text_styles.dart';
import 'horizontal_spacer.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final String? icon;
  final VoidCallback onClick;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? textSize;

  const ProfileRow({
    super.key,
    required this.title,
    this.icon,
    required this.onClick,
    this.horizontalPadding,
    this.textSize,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h, horizontal: horizontalPadding ?? 18.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null) ...[
              Container(
                height: 34.r,
                width: 34.r,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.backBgColor),
                child: Padding(padding: REdgeInsets.all(7), child: Image.asset(icon!)),
              ),
              HorizontalSpacer(width: 12.w)
            ],
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.medium500(color: AppColors.headlineTextColor, fontSize: textSize ?? AppSize.fontSize14),
              ),
            ),
            Image.asset("assets/icons/icon_forward.png", width: 9.w)
          ],
        ),
      ),
    );
  }
}
