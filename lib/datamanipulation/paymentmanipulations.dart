import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
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

  //creating sms intance

  final Smscontroller sms = Smscontroller();

  // intilizing bluetooth conections
  final _bluetoothClassicPlugin = BluetoothClassic();
  // payment handling by flutterwave
  var responseTxf = '';
  var resposeSuccess = '';
  final transactionRef = Uuid().v1().toString();
  handlePaymentInitialization() async {
    // final Customer customer = Customer(email: "customer@customer.com");
    final Customer customer = Customer(
        name: "Tumaini Rweyendera",
        phoneNumber: userPhoneNumber,
        email: useremail);

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
    showLoading(
      response.toString(),
    );

    //print("${response.toJson()}");
    print('The status is :${transactionRef}');
    print('The txRef is :${responseTxf}');
    print('The status is :${resposeSuccess}');

    // automatic token sending after complete payment status
  }

//

  sendTokens() async {
    if (responseTxf == transactionRef && resposeSuccess == "true") {
      // then check for bluetooth connetion if available

      //   await _bluetoothClassicPlugin.write("4575");

      // send the tokens to the meters mobile number
      sms.SendSms('token is:U60645U6U04');
    }
  }
//

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
