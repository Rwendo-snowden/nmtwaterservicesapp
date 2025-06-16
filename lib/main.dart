import 'dart:ffi';
import 'dart:ui';

import 'package:easy_sms_receiver/easy_sms_receiver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/paybyphonemodel.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';

import 'package:flutterwavepaymenttesting/firebase_options.dart';
import 'package:flutterwavepaymenttesting/pages/adminfolder/userRegistrationpage.dart';
import 'package:flutterwavepaymenttesting/pages/dashboardpage.dart';
import 'package:flutterwavepaymenttesting/pages/loginPage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  // final plugin = EasySmsReceiver.instance;

  //final telephony = Telephony.instance;

  //plugin.listenIncomingSms(
  // onNewMessage: (message) async {
  // if (service is AndroidServiceInstance) {
  //  service.setForegroundNotificationInfo(
  //    title: message.address ?? "SMS Received",
  //    content: message.body ?? "",
  //  );
  //}

  // print("📩 SMS from ${message.address}: ${message.body}");
  //print('rwendo');
  // Process your SMS here
  //
  // Extract details from the SMS using your parser
  //  final parsed = SmsDetails.fromMessage(message.body.toString());
//       print("🆔 Transaction IDs: ${parsed.transactionId}");
//       print("👤 Recipient: ${parsed.recipientName}");
//       print('amount:${parsed.amountPaid}');

//       String? meterNo = prefs.getString('Meter_NO') ?? 'No meter number ';
// //
//       double am = double.parse(parsed.amountPaid.toString());
//       double literObtained = am / 1000;

// //
//       if (parsed.recipientName == 'MELTRIDES MZEE RWEYENDERA') {
//         if (meterNo == '1') {
//           await telephony.sendSms(
//             to: '0747597935', // or any custom number
//             message: 'A:$literObtained,B:0,C:0',
//           );

//           print("📤 Response sent to ");
//         } else if (meterNo == "2") {
//           await telephony.sendSms(
//             to: '0747597935', // or any custom number
//             message: 'A:0,B:$literObtained,C:0',
//           );
//         } else if (meterNo == "3") {
//           await telephony.sendSms(
//             to: '0747597935', // or any custom number
//             message: 'A:0,B:0,C:$literObtained',
//           );
//         }
//       }

  // print('The meter number is $meterNo');
  //  },
  // );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.sms.request();

  FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(),
  );

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
      //home: Dashboardpage(),
    );
  }
}
