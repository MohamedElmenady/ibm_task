import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/network/cach_network.dart';
import 'package:second_app/core/network/network.dart';

class LoginModel extends ChangeNotifier {
  String errorMessage = '';
  bool isLoading = false;
  bool success = false;
  bool hasInternetConnection = true;
  StreamSubscription? _internetSubscription;

  LoginModel() {
    // Subscribe to the internet connection stream
    _internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      hasInternetConnection = status == InternetConnectionStatus.connected;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _internetSubscription
        ?.cancel(); // Cancel the subscription when the model is disposed
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {
    isLoading = true;
    notifyListeners();
//alshimaa.refaat@ibm.com //123456
    if (hasInternetConnection) {
      final response = await http.post(
        Uri.parse(ApiConstant.loginBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );
      dynamic jsonDecod = jsonDecode(response.body);

      if (jsonDecod['status'] == true) {
        errorMessage = jsonDecod['message'];
        success = true;
        await CashNetwork.set(key: 'token', value: jsonDecod['data']['token']);
        notifyListeners();
      } else {
        errorMessage = jsonDecod['message'];
      }
    } else {
      errorMessage = NetworkInfo.notFound;
      isLoading = false;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }
}
