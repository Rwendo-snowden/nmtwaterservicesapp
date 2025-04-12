import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/bluetoothServices.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/commomvariables.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/tokenmanipulation.dart';
import 'package:flutterwavepaymenttesting/pages/dashboardpage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PaymentManipulation {
  final context;
  final useremail;
  final userPhoneNumber;
  final amount;

  PaymentManipulation(
      {required this.amount,
      required this.context,
      required this.userPhoneNumber,
      required this.useremail});

  //creating Tokenmanipulation instance

  final Tokenmanipulation tokenmanipulation = Tokenmanipulation();

  //creating sms intance
  final Smscontroller sms = Smscontroller();

  // intilizing bluetooth conections
  final _bluetoothClassicPlugin = BluetoothClassic();
  final Bluetoothservices bluetoothservices = Get.put(Bluetoothservices());

  // payment handling by flutterwave
  var responseTxf = '';
  var resposeSuccess = '';
  final transactionRef = Uuid().v1().toString();
  handlePaymentInitialization() async {
    // final Customer customer = Customer(email: "customer@customer.com");
    final Customer customer = Customer(
      name: "Tumaini Rweyendera",
      phoneNumber: userPhoneNumber,
      email: useremail,
    );

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-6420f23276f1a3c6bb35aa9423158b8f-X",
        currency: "TZS",
        redirectUrl: 'https://facebook.com',
        txRef: transactionRef,
        amount: amount,
        customer: customer,
        paymentOptions:
            "card, payattitude, barter, bank transfer, ussd,mobile money",
        customization: Customization(title: " Water Payment"),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();

    responseTxf = response.txRef.toString();
    resposeSuccess = response.success.toString();

    sendTokens();
    showLoading(response.toString(), resposeSuccess);

    //print("${response.toJson()}");
    print('The status is :${transactionRef}');
    print('The txRef is :${responseTxf}');
    print('The status is :${resposeSuccess}');

    // automatic token sending after complete payment status
  }

//

// SEND TOKENS VIA BLUETOOTH
  sendBlueTOKENS() async {
    try {
      if (responseTxf == transactionRef && resposeSuccess == "true") {
        var Token = await tokenmanipulation.CreateToken(amount);
        // await _bluetoothClassicPlugin.write("sent via bluetooth 4575");
        await _bluetoothClassicPlugin.write("${Token} lts");
      }
    } catch (e) {
      print(e);
      print('Meter not connected');
    }
  }

// This is a function for sending tokens
  sendTokens() async {
    if (responseTxf == transactionRef && resposeSuccess == "true") {
      // then check for bluetooth connetion if available
      if (bluetoothservices.isConnected) {
        sendBlueTOKENS();
      } else {
        // send the tokens to the meters mobile number
        sms.SendSms('tokenis:U60645U6U04');
      }
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
        sms.SendSms(' ERROR CODE: Transactionfailed');
        print('i reached here');
      }
      // sms.SendSms('unbelivablethings');
      // print('i reached ttthere');
    }
  }
//

  Future<void> showLoading(String message, String responseStatus) {
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
              child: responseStatus == 'true'
                  ? Column(
                      children: [
                        Text(
                          'COMPLETED !',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.mark_chat_read),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          'UNSUCCESSFUL !',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.wrong_location),
                      ],
                    )),
        );
      },
    );
  }
}
