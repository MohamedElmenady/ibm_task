import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_app/core/helper/app_regex.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/widgets/app_text_form_field.dart';
import 'package:second_app/features/login/provider/login_provider.dart';
import 'package:second_app/features/login/ui/widgets/password_validations.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  bool hasNumber = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<LoginModel>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasNumber = AppRegex.hasNumber(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginModel>(
      builder: (context, loginModel, child) {
        return Form(
          key: loginModel.formKey,
          child: Column(
            children: [
              AppTextFormField(
                controller: loginModel.emailController,
                hintText: AppString.typeEmail,
                lableText: AppString.email,
                prefex: const Icon(Icons.person),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return AppString.validEmail;
                  }
                },
              ),
              verticalSpace(18),
              AppTextFormField(
                controller: loginModel.passwordController,
                hintText: AppString.typePassword,
                lableText: AppString.password,
                isObscureText: isObscureText,
                prefex: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !hasNumber) {
                    return AppString.validPassword;
                  }
                },
              ),
              verticalSpace(24),
              PasswordValidations(
                hasNumber: hasNumber,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
