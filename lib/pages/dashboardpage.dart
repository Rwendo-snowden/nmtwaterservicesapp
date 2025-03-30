import 'dart:typed_data';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:flutterwavepaymenttesting/pages/TokenPage.dart';
import 'package:flutterwavepaymenttesting/pages/paymentpage.dart';
import 'package:flutterwavepaymenttesting/wigdets/dashboardwidgets/card.dart';
import 'package:flutterwavepaymenttesting/wigdets/dashboardwidgets/rwendobarchart.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  // String platformVersions = 'Unknown';
  // final bluetoothClassicPlugin = BluetoothClassic();
  // List<Device> devices = [];
  // List<Device> discoveredDevices = [];

  // int deviceStatus = Device.disconnected;
  // Uint8List _data = Uint8List(0);
  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  //   bluetoothClassicPlugin.onDeviceStatusChanged().listen((event) {
  //     setState(() {
  //       deviceStatus = event;
  //     });
  //   });
  //   bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
  //     setState(() {
  //       _data = Uint8List.fromList([..._data, ...event]);
  //     });
  //   });
  // }

  // this the list of my barcharts data
  List barchartdata = [
    {'MON': 'JAN', 'value': 0.3},
    {'MON': 'FEB', 'value': 0.7},
    {'MON': 'MAR', 'value': 0.4},
    {'MON': 'APR', 'value': 0.6},
    {'MON': 'MAY', 'value': 0.8},
    {'MON': 'JUN', 'value': 0.9},
    {'MON': 'JUL', 'value': 0.48},
    {'MON': 'AUG', 'value': 0.46},
    {'MON': 'SEP', 'value': 0.55},
    {'MON': 'OCT', 'value': 0.4},
    {'MON': 'NOV', 'value': 0.9},
    {'MON': 'DEC', 'value': 0.6},
  ];

  // create an instance of sms controller
  final Smscontroller sms = Smscontroller();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit?'),
            content: Text('Do you want to Exit'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              )
            ],
          ),
        );
        if (shouldExit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 227, 227),
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notification_add_outlined),
            ),
          ],
        ),
        drawer: Drawer(),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 0.02 * width,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        sms.SendSms('45678238293892823');
                      },
                      icon: Icon(Icons.person),
                    ),
                    radius: width * 0.08,
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  const Text(
                    'METER NO: 243000589737',
                    style: TextStyle(
                        color: Color.fromARGB(255, 99, 97, 97),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),

              SizedBox(
                height: height * 0.02,
              ),
              // this is the water balance container
              Row(children: [
                SizedBox(
                  width: width * 0.03,
                ),
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: const Color.fromARGB(255, 60, 129, 232),
                    color: Colors.white,
                  ),
                  height: height * 0.12,
                  width: width * 0.93,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Balance :',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '2000 lts',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        ),
                        CircularPercentIndicator(
                          center: const Icon(
                            Icons.water_drop_rounded,
                            color: Colors.blue,
                          ),
                          radius: 40,
                          lineWidth: 12,
                          percent: 0.7,
                          progressColor:
                              const Color.fromARGB(255, 63, 113, 198),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dasboardcards(
                    width: width,
                    height: height,
                    title: 'top UP',
                    color: const Color.fromARGB(255, 60, 129, 232),
                    Icon: Icon(Icons.arrow_upward),
                    page: Paymentpage(),
                  ),
                  dasboardcards(
                    page: Tokenpage(),
                    width: width,
                    height: height,
                    title: " TOKEN ",
                    color: Colors.lightBlue,
                    Icon: Icon(Icons.edit_document),
                  )
                ],
              ),
              //history column
              SizedBox(
                height: height * 0.04,
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  height: height * 0.45,
                  width: width * 0.9,
                  child: ListView(
                    children: [
                      ...barchartdata.map((e) {
                        return Column(
                          children: [
                            Rwendobarchart(
                                width: width,
                                label: e['MON'].toString(),
                                percent: e['value']),
                            SizedBox(
                              height: height * 0.015,
                            )
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
