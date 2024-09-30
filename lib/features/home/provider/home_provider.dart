import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/network/network.dart';
import 'package:second_app/features/home/data/home_model.dart';
import 'package:second_app/features/home/provider/home_state.dart';

class HomeProvider extends Cubit<HomeState> {
  HomeProvider() : super((InitialState())) {
    _monitorInternetConnection();
  }

  void _monitorInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(LoginInternetConnected());
      } else {
        emit(LoginInternetDisconnected(error: NetworkInfo.notFound));
      }
    });
  }

  String searchQuery = '';
  bool isVisible = true;
  List<HomeModel> home = [];
  getData() async {
    if (state is LoginInternetDisconnected) {
      emit(LoginInternetDisconnected(error: NetworkInfo.notFound));
    }
    emit(HomeLoading());
    final response = await http.get(Uri.parse(ApiConstant.homeBaseUrl));
    var jsonDecod = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in jsonDecod) {
        home.add(HomeModel.formjson(data: item));
      }
      emit(HomeSuccess());
      return;
    } else {
      emit(HomeError(error: 'Not Found'));
      return;
    }
  }

  Future<void> refreshData() async {
    home.clear();
    await getData();
    emit(HomeRefresh());
  }

  List<HomeModel> get filterMessages {
    if (searchQuery.isEmpty) {
      return home;
    } else {
      return home.where((item) {
        return item.userName!
                .trim()
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            item.id == searchQuery;
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    emit(HomeSerching());
  }

  void expandUnexpand() {
    isVisible = !isVisible;
    emit(HomeExpandUnexpand());
  }
}
