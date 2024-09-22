import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/network/network.dart';
import 'package:second_app/core/screens/layout.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/styles.dart';
import 'package:second_app/core/widgets/app_text_button.dart';
import 'package:second_app/features/login/provider/login_provider.dart';
import 'package:second_app/features/login/ui/widgets/dont_have_account_text.dart';
import 'package:second_app/features/login/ui/widgets/email_and_password.dart';
import 'package:second_app/features/login/ui/widgets/terms_and_conditions_text.dart';

class LoginScreen1 extends StatelessWidget {
  const LoginScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    //final loginModel = Provider.of<LoginModel>(context);
    return ChangeNotifierProvider(
      create: (context) => LoginModel(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              child:
                  Consumer<LoginModel>(builder: (context, loginModel, child) {
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
                    loginModel.isLoading
                        ? const CircularProgressIndicator()
                        : AppTextButton(
                            buttonText: AppString.login.toUpperCase(),
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () async {
                              if (loginModel.formKey.currentState?.validate() ??
                                  false) {
                                await loginModel.login();
                                if (loginModel.success) {
                                  Navigator.pushReplacement(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyTabScreen(),
                                    ),
                                  );
                                }
                                if (loginModel.errorMessage.isNotEmpty) {
                                  await showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: loginModel.success
                                            ? Text(AppString.success)
                                            : Text(AppString.error),
                                        content: Text(loginModel.errorMessage),
                                        actions: [
                                          TextButton(
                                            child: loginModel.success
                                                ? Text(AppString.continu)
                                                : Text(AppString.ok),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ]),
                                  );
                                } else {}
                              }
                            }),
                    verticalSpace(16),
                    const TermsAndConditionsText(),
                    verticalSpace(100),
                    const DontHaveAccountText(),
                    verticalSpace(12),
                    loginModel.hasInternetConnection == false
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
      ),
    );
  }
}
