import 'package:flutter/foundation.dart';
import 'package:submission3/data/db/database_helper.dart';
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    _getBookmarks();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarkedArticle = await databaseHelper.getBookmarkById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await databaseHelper.removeBookmark(id);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }


}