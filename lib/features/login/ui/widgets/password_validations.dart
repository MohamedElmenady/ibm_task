import 'package:flutter/material.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/colors.dart';
import 'package:second_app/core/theming/styles.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasNumber;

  const PasswordValidations({
    super.key,
    required this.hasNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(AppString.atLeast, hasNumber),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: ColorsManager.gray,
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? ColorsManager.gray : ColorsManager.darkBlue,
          ),
        )
      ],
    );
  }
}
