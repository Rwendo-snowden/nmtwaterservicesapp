import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutterwavepaymenttesting/firebase_options.dart';
import 'package:flutterwavepaymenttesting/pages/adminfolder/userRegistrationpage.dart';
import 'package:flutterwavepaymenttesting/pages/dashboardpage.dart';
import 'package:flutterwavepaymenttesting/pages/loginPage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NMT water services ',
      home: LoginPage(),
      // home: RegisterPage(),
      //home: RegistrationPage(),
    );
  }
}
