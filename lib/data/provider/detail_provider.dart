import 'dart:async';

import 'package:flutter/material.dart';
import 'package:submission3/data/model/restaurant_details.dart';
import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;

  String id;

  DetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetails(id);
  }

  late RestaurantDetails _restaurantDetails;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  RestaurantDetails get result => _restaurantDetails;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetails(String? id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetails = await apiService.detailList(id);
      if (restaurantDetails.restaurantDetailsData.menus.foods.isEmpty && restaurantDetails.restaurantDetailsData.menus.drinks.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetails = restaurantDetails;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
