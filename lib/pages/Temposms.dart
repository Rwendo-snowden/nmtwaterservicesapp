import 'package:flutter/material.dart';
import 'package:telephony_sms/telephony_sms.dart';

class SMSSENDEER extends StatefulWidget {
  const SMSSENDEER({super.key});

  @override
  State<SMSSENDEER> createState() => _SMSSENDEERState();
}

class _SMSSENDEERState extends State<SMSSENDEER> {
  final _telephonySMS = TelephonySMS();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TelephonySMS Plugin example app'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _telephonySMS.requestPermission();
                },
                child: const Text('Check Permission'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _telephonySMS.sendSMS(
                      phone: "255747597935", message: "MESSAGE");
                },
                child: const Text('Send SMS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
