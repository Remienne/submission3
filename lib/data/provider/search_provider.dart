import 'dart:async';

import 'package:flutter/material.dart';
import 'package:submission3/data/model/restaurant_result.dart';
import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  String query;

  SearchProvider({required this.apiService, required this.query}) {
    fetchRestaurantSearch(query);
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  RestaurantResult get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.searchList(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}