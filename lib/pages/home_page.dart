import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission3/data/provider/scheduling_provider.dart';
import 'package:submission3/pages/detail_page.dart';
import 'package:submission3/pages/list_page.dart';
import 'package:submission3/pages/settings_page.dart';
import 'package:submission3/utils/notification_helper.dart';

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

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const ListPage(),
    const SearchPage(),
    const FavoritePage(),
    const SettingsPage(),
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

    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: _settingsText
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        DetailPage.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }
}