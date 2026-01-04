import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/text_styles.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final bool isLeft;

  const MyRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final radioIcon = Image.asset(
      isSelected ? "assets/icons/icon_check_radio.png" : "assets/icons/icon_uncheck_radio.png",
      height: 20.r,
      width: 20.r,
    );

    final label = Expanded(
      child: Text(
        value.toString(),
        style: AppTextStyle.medium500().copyWith(
          color: AppColors.headlineTextColor,
          fontSize: AppSize.fontSize16,
        ),
      ),
    );

    return GestureDetector(
      onTap: () => onChanged(value),
      child: SizedBox(
        height: 35.h,
        child: Row(
          children: isLeft ? [radioIcon, SizedBox(width: 8.w), label] : [label, SizedBox(width: 8.w), radioIcon],
        ),
      ),
    );
  }
}
