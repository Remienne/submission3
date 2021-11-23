import 'package:flutter/material.dart';
import 'package:submission3/pages/list_page.dart';

import 'favorites_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _restaurantText = 'Restaurants';
  static const String _searchText = 'Search';
  static const String _settingsText = 'Settings';
  static const String _favoriteText = 'Favorites';

  // final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const ListPage(),
    const SearchPage(),
    const FavoritePage(),

  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: _restaurantText,
    ),

    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: _searchText
    ),

    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: _favoriteText
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,

      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }
}