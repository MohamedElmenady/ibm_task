import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_app/core/helper/extention.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/network/network.dart';
import 'package:second_app/core/routing/routes.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/styles.dart';
import 'package:second_app/core/widgets/app_text_button.dart';
import 'package:second_app/features/login/provider/login_provider.dart';
import 'package:second_app/features/login/provider/login_state.dart';
import 'package:second_app/features/login/ui/widgets/dont_have_account_text.dart';
import 'package:second_app/features/login/ui/widgets/email_and_password.dart';
import 'package:second_app/features/login/ui/widgets/terms_and_conditions_text.dart';

class LoginScreen1 extends StatelessWidget {
  const LoginScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final loginModel = BlocProvider.of<LoginModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: BlocConsumer<LoginModel, LoginState>(
                listener: (context, state) {
              if (state is ErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text(AppString.error),
                      content: Text(state.error),
                      actions: [
                        TextButton(
                          child: Text(AppString.ok),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ]),
                );
              } else if (state is SuccessState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text(AppString.success),
                      content: Text(state.scucces),
                      actions: [
                        TextButton(
                            child: Text(AppString.continu),
                            onPressed: () {
                              context.pop();
                              context.pushReplacementNamed(Routes.layout);
                            }),
                      ]),
                );
              }
            }, builder: (context, state) {
              return Column(children: [
                Text(
                  AppString.login,
                  style: TextStyles.font24BlackBold,
                ),
                verticalSpace(20),
                Column(children: [
                  const EmailAndPassword(),
                  verticalSpace(24),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      AppString.forget,
                      style: TextStyles.font13GrayRegular,
                    ),
                  ),
                  verticalSpace(30),
                  state is LoadingState
                      ? const CircularProgressIndicator()
                      : AppTextButton(
                          buttonText: AppString.login.toUpperCase(),
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () async {
                            if (loginModel.formKey.currentState?.validate() ??
                                false) {
                              await loginModel.login();
                            }
                          }),
                  verticalSpace(16),
                  const TermsAndConditionsText(),
                  verticalSpace(100),
                  const DontHaveAccountText(),
                  verticalSpace(12),
                  state is LoginInternetDisconnected
                      ? Text(
                          NetworkInfo.notFound,
                          style: const TextStyle(color: Colors.red),
                        )
                      : Container()
                ]),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}
