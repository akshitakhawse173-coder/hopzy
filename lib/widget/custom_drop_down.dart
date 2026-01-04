import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/radius_size.dart';
import '../theme/text_styles.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final TextStyle style;
  final Function onChanged;
  final List<String> listItems;
  final String? selectedValue;
  final bool isEditable;
  final Color? fillColor;
  final double borderWidth;
  final double borderRadius;

  CustomDropDown({
    required this.style,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.listItems,
    this.selectedValue,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.rightPadding = 0,
    this.leftPadding = 0,
    this.isEditable = true,
    this.fillColor,
    this.borderWidth = 1,
    this.borderRadius = 8,
    Key? key,
  }) : super(key: key) {
    if (selectedValue != null) {
      controller.text = selectedValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftPadding, right: rightPadding, top: topPadding, bottom: bottomPadding),
      decoration: BoxDecoration(color: fillColor, borderRadius: BorderRadius.all(Radius.circular(RadiusSize.radiusSize8))),
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        hint: Text(hintText, style: AppTextStyle.regular400(color: AppColors.hintTextColor, fontSize: AppSize.fontSize14)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.editTextBorderColor, width: borderWidth.w),
              borderRadius: BorderRadius.circular(borderRadius.r)),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.editTextBorderColor, width: borderWidth.w),
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.editTextBorderColor, width: borderWidth.w),
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        items: listItems
            .map(
              (item) => DropdownMenuItem<String>(value: item, child: Text(item, style: style)),
            )
            .toList(),
        value: selectedValue,
        validator: (value) {
          if (value == null) {
            return 'Please working days';
          }
          return null;
        },
        iconStyleData: IconStyleData(icon: Image.asset('assets/icons/down_icon.png'), iconSize: 24.r),
        onChanged: isEditable
            ? (value) {
                if (value != null) {
                  onChanged(value);
                  controller.value = TextEditingValue(text: value);
                }
              }
            : null,
        onSaved: (value) {},
        dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8))),
        menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.symmetric(horizontal: 16)),
      ),
    );
  }
}
