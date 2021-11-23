import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/data/provider/main_list_provider.dart';
import 'package:submission3/pages/detail_page.dart';
import 'package:submission3/pages/favorites_page.dart';
import 'package:submission3/pages/list_page.dart';
import 'package:submission3/pages/search_page.dart';

import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'data/provider/database_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainListProvider(apiService: ApiService()),
        ),
        // ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: ListPage.routeName,
      routes: {
        ListPage.routeName: (context) =>  const ListPage(),
        SearchPage.routeName: (context) =>  const SearchPage(),
        FavoritePage.routeName: (context) =>  const FavoritePage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
      },
    ),
    );

  }
}

