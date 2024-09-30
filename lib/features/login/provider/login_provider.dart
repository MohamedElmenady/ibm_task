import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/network/cach_network.dart';
import 'package:second_app/core/network/network.dart';
import 'package:second_app/features/login/provider/login_state.dart';

class LoginModel extends Cubit<LoginState> {
  LoginModel() : super(LoginInitial()) {
    _monitorInternetConnection();
  }

  void _monitorInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(LoginInternetConnected());
      } else {
        emit(LoginInternetDisconnected());
      }
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (state is LoginInternetDisconnected) {
      emit(ErrorState(error: NetworkInfo.notFound));
    }
    emit(LoadingState());
//alshimaa.refaat@ibm.com //123456
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
      await CashNetwork.set(key: 'token', value: jsonDecod['data']['token']);
      emit(SuccessState(scucces: jsonDecod['message']));
    } else {
      emit(ErrorState(error: jsonDecod['message']));
    }
  }
}
