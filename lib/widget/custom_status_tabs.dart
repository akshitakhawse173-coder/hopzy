import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/text_styles.dart';

class CustomStatusTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectedIndexChanged;
  final List<String> labels;
  double marginLeft, marginRight, marginTop, marginBottom;
  double height;

  CustomStatusTabs(
      {super.key,
      required this.selectedIndex,
      required this.onSelectedIndexChanged,
      required this.labels,
      this.height = 50,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.marginTop = 0,
      this.marginBottom = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height.h,
        margin: EdgeInsets.only(top: marginTop.h, bottom: marginBottom.h, left: marginLeft.w, right: marginRight.w),
        padding: REdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.outlineColor2),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: List.generate(
            labels.length, // Generate tabs based on the number of labels
            (index) => CustomStatusTab(
              index: index,
              selectedIndex: selectedIndex,
              label: labels[index],
              onTap: () => onSelectedIndexChanged(index),
            ),
          ),
        ));
  }
}

class CustomStatusTab extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final VoidCallback onTap;

  const CustomStatusTab({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: double.infinity,
          decoration: BoxDecoration(
            color: selectedIndex == index ? AppColors.blackColor : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium500().copyWith(
                color: selectedIndex == index ? AppColors.whiteColor : AppColors.blackColor,
                fontSize: AppSize.fontSize14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
