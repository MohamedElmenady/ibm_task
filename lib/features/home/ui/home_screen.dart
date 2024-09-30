import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/core/helper/extention.dart';
import 'package:second_app/core/helper/spacing.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/network/cach_network.dart';
import 'package:second_app/core/routing/routes.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/colors.dart';
import 'package:second_app/core/theming/styles.dart';
import 'package:second_app/features/home/data/home_model.dart';
import 'package:second_app/features/home/provider/home_provider.dart';
import 'package:second_app/features/home/provider/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeProvider>(context);
    return BlocConsumer<HomeProvider, HomeState>(
      listener: (context, state) {
        if (state is LoginInternetDisconnected) {
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
        }
      },
      builder: (context, state) {
        List<HomeModel> filteredMessages = cubit.filterMessages;
        return cubit.home.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => cubit.refreshData(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.sponsord,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          verticalSpace(12),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  foregroundImage:
                                      AssetImage('assets/images/images.jpg'),
                                  radius: 30,
                                ),
                                horizontalSpace(4),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppString.orignalCloth,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            horizontalSpace(20),
                                            IconButton(
                                              onPressed: () {
                                                cubit.expandUnexpand();
                                              },
                                              icon: Icon(
                                                cubit.isVisible
                                                    ? Icons.expand_less
                                                    : Icons.expand_more,
                                                color: ColorsManager.gray,
                                              ),
                                            ),
                                          ]),
                                      Visibility(
                                        visible: cubit.isVisible,
                                        child: Text(
                                          AppString.favorits,
                                          textAlign: TextAlign.start,
                                          style: TextStyles.font14GrayRegular,
                                        ),
                                      ),
                                      Visibility(
                                        visible: cubit.isVisible,
                                        child: SizedBox(
                                          //height: 150,
                                          width: 170,
                                          child: Image.asset(
                                              'assets/images/download.png'),
                                        ),
                                      ),
                                      verticalSpace(4),
                                      Visibility(
                                        visible: cubit.isVisible,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(
                                                  AppString.freeShoping,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyles
                                                      .font13GrayRegular,
                                                ),
                                              ),
                                              horizontalSpace(34),
                                              TextButton(
                                                onPressed: () async {
                                                  await CashNetwork.deletAll(
                                                      key: 'token');
                                                  debugPrint(ApiConstant.token);
                                                  // ignore: use_build_context_synchronously
                                                  context.pushReplacementNamed(
                                                      Routes.loginScreen);
                                                },
                                                child: Text(AppString.shopNow),
                                              ),
                                            ]),
                                      ),
                                    ]),
                              ]),
                        ]),
                    verticalSpace(12),
                    Text(AppString.moreConversation,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    ListView.builder(
                        itemCount: filteredMessages.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          HomeModel messages = filteredMessages[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/images/images.jpg'),
                              radius: 25,
                            ),
                            title:
                                Text("${messages.userName!} (${messages.id!})"),
                            subtitle: Text(messages.message!),
                            trailing: const Text("Fri"),
                          );
                        }),
                  ]),
                ),
              );
      },
    );
  }
}
