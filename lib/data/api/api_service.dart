import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/data/model/restaurant_details.dart';


class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _main = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';


  Future<RestaurantList> mainList() async {
    final response = await http.get(Uri.parse(_baseUrl +_main));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetails> detailList(String? id) async {
    final response = await http.get(Uri.parse(_baseUrl +_detail+id!));
    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  Future<RestaurantResult> searchList(String query) async {
    final response = await http.get(Uri.parse(_baseUrl +_search+query));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

}