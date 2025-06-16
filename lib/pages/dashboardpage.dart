import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwavepaymenttesting/Databases/Dbcontrollers/LocalDatabase.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/bluetoothServices.dart';

import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/tokenmanipulation.dart';
import 'package:flutterwavepaymenttesting/pages/TokenPage.dart';
import 'package:flutterwavepaymenttesting/pages/paymentpage.dart';
import 'package:flutterwavepaymenttesting/wigdets/Appbar.dart';
import 'package:flutterwavepaymenttesting/wigdets/dashboardwidgets/card.dart';
import 'package:flutterwavepaymenttesting/wigdets/dashboardwidgets/rwendobarchart.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
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

// bluetooth intialization here !!

  //
  final Bluetoothservices bluetoothservices = Get.put(Bluetoothservices());

  // payment local db intialization
  final DbController localDb = Get.put(DbController());

  //
  final Tokenmanipulation mn = Tokenmanipulation();
  //
  //taking data from shared preferences
  String meterNumber = '';
  String Email = '';
  String Pnumber = '';
  String Uname = '';
  String wBalance = '';
  @override
  void initState() {
    super.initState();
    _loadUserSession(); // call the async method without awaiting
  }

  void _loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username');
    String? meterNo = prefs.getString('Meter_NO');
    String? Phonenumber = prefs.getString('Phonenumber');
    String? email = prefs.getString('email');
    String? waterbalance =
        prefs.getDouble('waterbalance').toString() ?? '0 liters';

    setState(() {
      meterNumber = meterNo ?? 'Unknown'; // or default fallback
      Pnumber = Phonenumber.toString();
      Email = email.toString();
      Uname = username.toString();
      wBalance = waterbalance.toString();
    });

    if (username != null) {
      print('Logged in user: $username');
      // Optionally do more with the username
    }
  }

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
        appBar: NMTAPPBAR(bluetoothservices: bluetoothservices),
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
                    radius: width * 0.08,
                    child: IconButton(
                      onPressed: () async {
                        //sms.SendSms('45678238293892823');

                        // var tk = await mn.CreateToken('2000');
                        // print('the tk is :$tk');
                      },
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Text(
                    //'METER NO: 243000589737',ME
                    // 'METER NO: 246000589738',DEUS
                    'METER NO: $meterNumber',

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
                        InkWell(
                          onTap: () async {
                            _loadUserSession();
                            if (meterNumber == "1") {
                              await sms.SendSms('BALANCE A');

                              _showMyDialog(context);
                            } else if (meterNumber == "2") {
                              await sms.SendSms('BALANCE B');
                              _showMyDialog(context);
                            } else if (meterNumber == "3") {
                              await sms.SendSms('BALANCE C');
                              _showMyDialog(context);
                            }
                          },
                          child: Text(
                            "$wBalance ltrs",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w300),
                          ),
                        ),
                        CircularPercentIndicator(
                          center: const Icon(
                            Icons.water_drop_rounded,
                            color: Colors.blue,
                          ),
                          radius: width * 0.095,
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
                    page: Paymentpage(
                      mobilenumber: Pnumber,
                      useremail: Email,
                      username: Uname,
                      meterno: meterNumber,
                    ),
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
                        return Rwendobarchart(
                          width: width,
                          label: e['MON'].toString(),
                          percent: e['value'],
                          height: height,
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

void _showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(""),
        content: Text("balance requested successfully wait for sms shortly ! "),
        actions: [
          TextButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
