
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission3/common/custom_dialog.dart';
import 'package:submission3/data/provider/preferences_provider.dart';
import 'package:submission3/data/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget{
  static const routeName = '/restaurant_settings';

  const SettingsPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _buildList(context)
      );
    }

    Widget _buildList(BuildContext context) {
      return SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Settings",
                            style: TextStyle(fontSize: 30.0, fontFamily: 'UbuntuRegular'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Restaurants Notification'),
                            trailing: Consumer<SchedulingProvider>(
                              builder: (context, scheduled, _) {
                                return Switch.adaptive(
                                  value: provider.isDailyNewsActive,
                                  onChanged: (value) async {
                                    if (Platform.isIOS) {
                                      customDialog(context);
                                    } else {
                                      scheduled.scheduledRecommendation(value);
                                      provider.enableDailyNews(value);
                                    }
                                  },
                                );
                              },
                            ),
                          );
                          },
                      )
                    ],
                  ),
                ),
              ],
            )
        ),
      );

    }
}



