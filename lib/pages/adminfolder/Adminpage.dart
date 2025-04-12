import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwavepaymenttesting/pages/TokenPage.dart';
import 'package:flutterwavepaymenttesting/pages/adminfolder/userRegistrationpage.dart';

import 'package:flutterwavepaymenttesting/wigdets/dashboardwidgets/card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
            title: const Text('Exit?'),
            content: const Text('Do you want to Exit'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
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
        appBar: AppBar(),
        drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
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
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                    ),
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
                          'Usage :',
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
                    title: 'Register',
                    color: const Color.fromARGB(255, 60, 129, 232),
                    Icon: const Icon(Icons.person),
                    page: RegistrationPage(),
                  ),
                  dasboardcards(
                    page: const Tokenpage(),
                    width: width,
                    height: height,
                    title: " Payments ",
                    color: Colors.lightBlue,
                    Icon: const Icon(Icons.money),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dasboardcards(
                    page: const Tokenpage(),
                    width: width,
                    height: height,
                    title: " Manage ",
                    color: Colors.amber,
                    Icon: const Icon(Icons.manage_accounts),
                  ),
                  dasboardcards(
                    page: const Tokenpage(),
                    width: width,
                    height: height,
                    title: " Settings ",
                    color: Colors.green,
                    Icon: const Icon(Icons.settings),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dasboardcards(
                    page: const Tokenpage(),
                    width: width,
                    height: height,
                    title: " Manage house ",
                    color: Colors.black26,
                    Icon: const Icon(Icons.apartment),
                  ),
                  dasboardcards(
                    page: const Tokenpage(),
                    width: width,
                    height: height,
                    title: " App Settings ",
                    color: Colors.pinkAccent,
                    Icon: const Icon(Icons.settings_system_daydream),
                  )
                ],
              ),
              //history column
              SizedBox(
                height: height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
