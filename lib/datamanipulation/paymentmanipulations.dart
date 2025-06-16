import 'dart:io';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwavepaymenttesting/Databases/Dbcontrollers/LocalDatabase.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/bluetoothServices.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/tokenmanipulation.dart';
import 'package:flutterwavepaymenttesting/wigdets/buttonUpdates.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PaymentManipulation {
  final context;
  final useremail;
  final userPhoneNumber;
  final amount;
  final username;
  final meterNo;

  PaymentManipulation({
    required this.amount,
    required this.context,
    required this.userPhoneNumber,
    required this.useremail,
    required this.username,
    required this.meterNo,
  });

  //creating Tokenmanipulation instance

  final Tokenmanipulation tokenmanipulation = Tokenmanipulation();

  var tokenRequied = '';
  var generatedtoken = '';

  //creating sms intance
  final Smscontroller sms = Smscontroller();

  // intilizing bluetooth conections
  final _bluetoothClassicPlugin = BluetoothClassic();
  final Bluetoothservices bluetoothservices = Get.put(Bluetoothservices());

  // payment button status
  final Buttonupdates paybuttonUpdates = Get.put(Buttonupdates());

  // instance of the local database controller

  final DbController LocalDB = Get.put(DbController());

  //

  // payment handling by flutterwave
  var responseTxf = '';
  var resposeSuccess = '';
  var responseStatus = '';
  final transactionRef = Uuid().v1().toString();
  handlePaymentInitialization() async {
    // final Customer customer = Customer(email: "customer@customer.com");
    final Customer customer = Customer(
      //name: "EMMANUEL ",
      //name: "Allyson",
      name: username,
      phoneNumber: userPhoneNumber,
      email: useremail,
    );

    final Flutterwave flutterwave = Flutterwave(
      // context: context,
      publicKey: "FLWPUBK_TEST-6420f23276f1a3c6bb35aa9423158b8f-X",
      currency: "TZS",
      redirectUrl: 'https://www.flutterwave.com',
      txRef: transactionRef,
      amount: amount,
      customer: customer,
      paymentOptions:
          "card, payattitude, barter, bank transfer, ussd,mobile money",
      // paymentOptions: "ussd, card, bank transfer",
      customization: Customization(title: " Water Payment"),
      isTestMode: true,
    );
    // final ChargeResponse response = await flutterwave.charge();
    final ChargeResponse response = await flutterwave.charge(context);

    responseTxf = response.txRef.toString();
    resposeSuccess = response.success.toString();
    responseStatus = response.status.toString();
    sendTokens();
    showLoading(response.toString(), responseStatus);
    //after this return the button status to normal
    paybuttonUpdates.backToNormal();

    //print("${response.toJson()}");
    print('The status is :${transactionRef}');
    print('The txRef is :${responseTxf}');
    print('The status is :${resposeSuccess}');
    print('transref is $responseStatus');

    // automatic token sending after complete payment status
  }

//

// SEND TOKENS VIA BLUETOOTH
  sendBlueTOKENS() async {
    try {
      // if (responseTxf == transactionRef && responseStatus == "successful") {
      if (responseStatus == "successful") {
        // var Token = await tokenmanipulation.CreateToken(amount);
        // tokenRequied = Token;
        int am = int.parse(amount);
        double literObtained = am / 1000;
        tokenRequied = literObtained.toString();
        // await _bluetoothClassicPlugin.write(literObtained.toString());
        await _bluetoothClassicPlugin.write('A:$tokenRequied,B:0,C:0');

        print(" the liters are: $literObtained");
      }
    } catch (e) {
      print(e);
      print('there is an error couldnt connect !');
    }
  }

// This is a function for sending tokens
  sendTokens() async {
    if (responseTxf == transactionRef && responseStatus == "successful") {
      // then check for bluetooth connetion if available
      if (bluetoothservices.isConnected) {
        sendBlueTOKENS();
      } else {
        int am = int.parse(amount);
        double literObtained = am / 100;
        tokenRequied = literObtained.toString();
        // await _bluetoothClassicPlugin.write(literObtained.toString());
        //await sms.SendSms('A:0,B:$tokenRequied,C:0');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //calculate the waterbalance here !
        double waterbalance;
        waterbalance = (prefs.getDouble('waterbalance') ?? 0.0) + literObtained;

        //
        prefs.setDouble('waterbalance', waterbalance);
        //
        // token calculation is here

        if (meterNo == "1") {
          await sms.SendSms('A:$tokenRequied,B:0,C:0');

          generatedtoken =
              await tokenmanipulation.CreateToken('A:$tokenRequied,B:0,C:0');

          // await sms.SendSms(generatedtoken);
          // Encrypt
        } else if (meterNo == "2") {
          await sms.SendSms('A:0,B:$tokenRequied,C:0');
          generatedtoken =
              await tokenmanipulation.CreateToken('A:0,B:$tokenRequied,C:0');
        } else if (meterNo == "3") {
          await sms.SendSms('A:0,B:0,C:$tokenRequied');
          generatedtoken =
              await tokenmanipulation.CreateToken('A:0,B:0,C:$tokenRequied');
        }

        print(" the liters sent by sms are: $literObtained");
        //await sms.SendSms(literObtained);
      }
      // save the Transaction details in the local database here
      Map<String, dynamic> payments = {
        'Tokens': generatedtoken,
        'TransactionID': responseTxf,
        'Amount': amount,
        'Liters': 25,
        'Time': DateTime.now().toString()
      };
      LocalDB.PutData(payments);
    } else {
      // when the transaction fails
      // this part of the code should be removed it meant only for testing purpose nothing shall be done when the transaction fails ie:send nothing to the meter
      if (bluetoothservices.isConnected) {
        try {
          await _bluetoothClassicPlugin
              .write("sorry but transaction has failed ");
        } catch (e) {
          print(e);
          print('Meter not connected');
        }
      } else {
        // send the tokens to the meters mobile number
        // sms.SendSms(' ERROR CODE: Transactionfailed');
        print('i reached here error!!!');
        //
        // Map<String, dynamic> pays = {
        //   'Tokens': '4445589',
        //   'TransactionID': 'djhjhejhqw',
        //   'Amount': 'unknown',
        //   'Liters': 25,
        //   'Time': DateTime.now().toString()
        // };
        // LocalDB.PutData(pays);
      }
      // sms.SendSms('unbelivablethings');
      // print('i reached ttthere');
    }
  }
//

  Future<void> showLoading(String message, String responseStatus) {
    // await sendBlueTOKENS();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
              width: double.infinity,
              height: 80,
              // child: Text(message),
              child: responseStatus == 'successful'
                  ? Column(
                      children: [
                        Text(
                          'COMPLETED !',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          'UNSUCCESSFUL !',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ],
                    )),
        );
      },
    );
  }
}
