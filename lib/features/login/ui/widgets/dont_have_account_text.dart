import 'package:flutter/material.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppString.usingSign, style: TextStyles.font13GrayRegular),
        verticalSpace(12),
        Text(AppString.signUp, style: TextStyles.font13GrayRegular)
      ],
    );
  }
}
