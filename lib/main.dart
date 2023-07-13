import 'package:banker/dash_board.dart';
import 'package:banker/group_sms_sender.dart';
import 'package:banker/string_construction_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'emi_with_repayment_holiday.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

const appId = 'ca-app-pub-1908792034570990~3880014882';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  List<String> testDeviceIds = ['E2F86CD2AF666AF5F3EF210439C2D931'];
  MobileAds.instance.initialize().then((InitializationStatus status) {
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: testDeviceIds,
    ));
  });
  MobileAds.instance.initialize();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // drawer: Drawer(),
        body: Center(
          child: GroupSmsSender(),
        ),
      ),
    );
  }
}
