import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppString.usingSign, style: TextStyles.font13GrayRegular),
        verticalSpace(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image.png', width: 50.h, height: 50.h),
            horizontalSpace(8),
            Image.asset('assets/images/download.png',
                width: 35.h, height: 35.h),
            horizontalSpace(8),
            Image.asset('assets/images/images.jpg', width: 50.h, height: 50.h),
          ],
        )
      ],
    );
  }
}
