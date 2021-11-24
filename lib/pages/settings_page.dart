
import 'dart:io';

import 'package:flutter_offline/flutter_offline.dart';
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
      return Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Scheduling News'),
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
                ),
              ),
            ],
          );
        },
      );
    }
}



