import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/features/home/data/home_model.dart';

class HomeProvider with ChangeNotifier {
  // String errorMessage = '';
  bool isLoading = false;
  bool success = false;
  String searchQuery = '';
  bool isVisible = true;
  List<HomeModel> home = [];
  getData() async {
    isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(ApiConstant.homeBaseUrl));
    var jsonDecod = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in jsonDecod) {
        home.add(HomeModel.formjson(data: item));
      }
      isLoading = false;
      success = true;
      notifyListeners();
      return;
    } else {
      isLoading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> refreshData() async {
    home.clear();
    await getData();
    notifyListeners();
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
    notifyListeners();
  }

  void expandUnexpand() {
    isVisible = !isVisible;
    notifyListeners();
  }
/*
  List<HomeModel> filterMessage = [];
  void filter(String data) {
    filterMessage = home
        .where((element) =>
            element.userName!.toLowerCase().startsWith(data.toLowerCase()) ||
            element.userName!.toUpperCase().startsWith(data.toUpperCase()) ||
            element.id!.startsWith(data))
        .toList();
    notifyListeners();
  }*/
}
