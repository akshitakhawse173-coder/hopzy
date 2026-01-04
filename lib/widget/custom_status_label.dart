import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_size.dart';
import '../theme/text_styles.dart';

class CustomStatusLabel extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final double horizontalPadding;
  final double verticalPadding;

  const CustomStatusLabel({
    super.key,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.verticalPadding = 2.0,
    this.horizontalPadding = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w, vertical: verticalPadding.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor.withOpacity(0.1),
      ),
      child: Text(
        label,
        style: AppTextStyle.medium500().copyWith(color: textColor, fontSize: AppSize.fontSize12),
      ),
    );
  }
}
