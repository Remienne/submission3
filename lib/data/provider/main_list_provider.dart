import 'dart:async';

import 'package:flutter/material.dart';
import 'package:submission3/data/model/restaurant.dart';
import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class MainListProvider extends ChangeNotifier {
  final ApiService apiService;

  MainListProvider({required this.apiService}) {
    _fetchRestaurantList();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.mainList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
