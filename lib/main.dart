import 'package:flutter/material.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/network/cach_network.dart';
import 'package:second_app/core/routing/app_route.dart';
import 'package:second_app/onBordeing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.intialise();
  ApiConstant.token = CashNetwork.get(key: 'token');
  // await CashNetwork.delet(key: 'token');
  debugPrint("toke : ${ApiConstant.token}");
  runApp(
    OnBordeingScreen(
      appRoute: AppRoute(),
    ),
  );
}
