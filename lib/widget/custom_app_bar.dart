import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/app_size.dart';
import '../../theme/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenName;
  final bool isShowBackBtn;
  final bool centerTitle;
  final double elevation;
  final VoidCallback onBackClick;
  final TextStyle? titleStyle;
  final Color? statusBarColor;

  CustomAppBar({
    super.key,
    required this.screenName,
    this.isShowBackBtn = true,
    this.titleStyle,
    required this.onBackClick,
    this.centerTitle = true,
    this.elevation = 1.5,
    this.statusBarColor,
  });

  final TextStyle style = AppTextStyle.medium500(
    fontSize: AppSize.fontSize18,
    color: AppColors.headlineTextColor,
  ).copyWith(height: 1.35);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.whiteColor,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: elevation,
      leading: isShowBackBtn
          ? GestureDetector(
              onTap: onBackClick,
              child: Padding(
                padding: REdgeInsets.only(left: 14.w),
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.backBgColor),
                  child: Image.asset("assets/icons/back_icon.png", height: 20.r, width: 20.r, scale: 2.5),
                ),
              ),
            )
          : null,
      backgroundColor: AppColors.backgroundColor,
      titleSpacing: 0,
      centerTitle: centerTitle,
      title: Padding(
        padding: EdgeInsets.only(left: isShowBackBtn ? 0 : 25.w),
        child: Text(screenName, style: titleStyle ?? style),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(54.h);
}
