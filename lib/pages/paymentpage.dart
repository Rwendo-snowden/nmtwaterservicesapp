import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/paymentmanipulations.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';

class Paymentpage extends StatefulWidget {
  const Paymentpage({super.key});

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
  final _Paymentformkey = GlobalKey<FormState>();

  String _amount = '';
  final _mobileNumber = "0613311958";
  final _useremail = "emmanuelrweyendera@gmail.com";
  final currency = "TZS";
  bool isTestmode = true;

  //intiialize sms controller

  final Smscontroller sms = Smscontroller();

  // var _deviceStatus = Device.disconnected;
  // final _bluetoothClassicPlugin = BluetoothClassic();
  // Uint8List _data = Uint8List(0);
  // String _platformVersion = 'Unknown';

  // void initState() {
  //   super.initState();
  //   // initPlatformState();
  //   try {
  //     _bluetoothClassicPlugin.onDeviceStatusChanged().listen(
  //       (event) {
  //         setState(() {
  //           _deviceStatus = event;
  //           print('The event is :${event}');
  //         });
  //       },
  //     );

  //     _bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
  //       setState(() {
  //         _data = Uint8List.fromList([..._data, ...event]);
  //       });
  //     });
  //   } catch (e) {
  //     print(e);
  //     print('This device is already intialized ');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          //   Text("Received data: ${String.fromCharCodes(_data)}"),
          // TextButton(
          //   onPressed: _deviceStatus == Device.connected
          //       ? () async {
          //           await _bluetoothClassicPlugin.disconnect();
          //         }
          //       : null,
          //   child: const Text("disconnect"),
          // ),
          // Container(
          //   child: _deviceStatus ==
          //           Device.disconnected // checking for the bluetooth status
          //       ? ElevatedButton(
          //           onPressed: () async {
          //             // the esp32  bluetooth (mac address) is :3C:71:BF:D5:0E:22
          //             try {
          //               await _bluetoothClassicPlugin.connect(
          //                   "3C:71:BF:D5:0E:22",
          //                   "00001101-0000-1000-8000-00805f9b34fb");
          //             } catch (e) {
          //               print(e);
          //               print(
          //                   'could not connect o device there is an execption occured');
          //             }
          //           },
          //           child: Text('Connect to water Meter'),
          //         )
          //       : Text('you are connected to meter'),
          // ),
          Form(
            key: _Paymentformkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Tafadhali weka kiasi  ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _amount = value!;
                  },
                  decoration: const InputDecoration(
                    label: Text('amount'),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    //sms.SendSms('yool');
                    if (_Paymentformkey.currentState!.validate()) {
                      _Paymentformkey.currentState!.save();
                      // after saving  the amount data then call the following funtion
                      // create an instance for the paymentManipulation
                      PaymentManipulation Pay = PaymentManipulation(
                          amount: _amount,
                          context: context,
                          userPhoneNumber: _mobileNumber,
                          useremail: _useremail);
                      // calling the manipulation value
                      Pay.handlePaymentInitialization();
                    }

                    // then call the payment handling function
                  },
                  child: const Text('pay'),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                PaymentManipulation Pay = PaymentManipulation(
                    amount: _amount,
                    context: context,
                    userPhoneNumber: _mobileNumber,
                    useremail: _useremail);
// send via the bluetooth tokens
                Pay.sendBlueTOKENS();
              },
              child: Text('Send bluetooth'))
        ],
      ),
    ));
  }

  // functions
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion = await _bluetoothClassicPlugin.getPlatformVersion() ??
  //         'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   //   // If the widget was removed from the tree while the asynchronous platform
  //   //   // message was in flight, we want to discard the reply rather than calling
  //   //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }
}
