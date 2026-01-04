import 'package:flutter/material.dart';

import '../theme/app_color.dart';
import '../theme/app_size.dart';
import '../theme/strings.dart';
import '../theme/text_styles.dart';

class NoDataFound extends StatelessWidget {
  final String? title;

  const NoDataFound({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text(title ?? Strings.noDataFound, style: AppTextStyle.regular400(fontSize: AppSize.fontSize14, color: AppColors.hintTextColor)),
    );
  }
}
