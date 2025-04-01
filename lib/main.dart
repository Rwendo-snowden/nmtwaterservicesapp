import 'package:flutter/material.dart';
import 'package:flutterwavepaymenttesting/pages/dashboardpage.dart';
import 'package:flutterwavepaymenttesting/pages/paymentpage.dart';

import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NMT water services ',
      // home: MyHomePage('Flutterwave Standard'),
      //home: Paymentpage(),
      //home: Tokenpage(),
      home: Dashboardpage(),
    );
  }
}
