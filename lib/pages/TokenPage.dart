import 'dart:typed_data';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/bluetoothServices.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:flutterwavepaymenttesting/wigdets/Appbar.dart';
import 'package:get/get.dart';

class Tokenpage extends StatefulWidget {
  const Tokenpage({super.key});

  @override
  State<Tokenpage> createState() => _TokenpageState();
}

class _TokenpageState extends State<Tokenpage> {
  final _Tokenformkey = GlobalKey<FormState>();
  var Token = '';
  //
  final Bluetoothservices bluetoothservices = Get.put(Bluetoothservices());
  final _bluetoothClassicPlugin = BluetoothClassic();
  final sms = Smscontroller();
  //

  @override
  Widget build(BuildContext context) {
    return
        //safe Area
        Scaffold(
      appBar: NMTAPPBAR(bluetoothservices: bluetoothservices),
      body: Column(
        children: [
          //
          Form(
            key: _Tokenformkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Tafadhali weka TOKEN  ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Token = value!;
                  },
                  decoration: const InputDecoration(
                    label: Text('TOKEN'),
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    //check for form validation
                    if (_Tokenformkey.currentState!.validate()) {
                      _Tokenformkey.currentState!.save();
                      // check if device is connceted to bluetooth ; if its connected then send the tokens
                      try {
                        // await _bluetoothClassicPlugin.write(Token);
                        sms.SendSms(Token);
                      } catch (e) {
                        print(e);
                        print('The meter is not connected ');
                      }
                    }
                  },
                  child: const Text('Send Tokens'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//
}
