import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwavepaymenttesting/Databases/Dbcontrollers/LocalDatabase.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/bluetoothServices.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/paymentmanipulations.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:flutterwavepaymenttesting/pages/PAYBYPHONE.dart';
import 'package:flutterwavepaymenttesting/wigdets/Appbar.dart';
import 'package:flutterwavepaymenttesting/wigdets/buttonUpdates.dart';
import 'package:flutterwavepaymenttesting/wigdets/paymentpagewidgets/statementbox.dart';
import 'package:get/get.dart';

class Paymentpage extends StatefulWidget {
  final username;
  final mobilenumber;
  final useremail;
  final meterno;

  const Paymentpage({
    super.key,
    required this.mobilenumber,
    required this.useremail,
    required this.username,
    required this.meterno,
  });

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
  final _Paymentformkey = GlobalKey<FormState>();

  String _amount = '';
  // final _mobileNumber = "0622000051";
  // final _useremail = "emmanuelrweyendera@gmail.com";
  //final _useremail = "deuszacharia596@gmail.com";
  //final _useremail = "allysonsanga97@gmail.com";
  final currency = "TZS";
  bool isTestmode = true;

  //intiialize sms controller

  final Smscontroller sms = Smscontroller();
//
  final Bluetoothservices bluetoothservices = Get.put(Bluetoothservices());

  // payment button status
  // var paybuttonstatus = 'Pay';
  final Buttonupdates paybuttonstatus = Get.put(Buttonupdates());

  //create an instance of local database
  final DbController localDb = Get.put(DbController());

  @override
  Widget build(BuildContext context) {
    //phone dimensions
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // the fetched data from database
    List fetchedPayments = localDb.paymentData;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 228, 228),
      appBar: NMTAPPBAR(bluetoothservices: bluetoothservices),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 235, 228, 228),
      //   toolbarHeight: height * 0.1,
      //   leading: IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.arrow_back_ios_new_sharp,
      //       )),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Form(
            key: _Paymentformkey,
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: width * 0.9,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " please insert amount  ";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _amount = value!;
                      },
                      decoration: const InputDecoration(
                        hintText: "e.g 10000",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ),

                // pay customized button
                GetBuilder<Buttonupdates>(
                  init: Buttonupdates(),
                  initState: (_) {},
                  builder: (_) {
                    return InkWell(
                      onTap: () {
                        if (_Paymentformkey.currentState!.validate()) {
                          _Paymentformkey.currentState!.save();
                          // after saving  the amount data then call the following funtion
                          // create an instance for the paymentManipulation
                          PaymentManipulation Pay = PaymentManipulation(
                            amount: _amount,
                            context: context,
                            userPhoneNumber: widget.mobilenumber,
                            useremail: widget.useremail,
                            username: widget.username,
                            meterNo: widget.meterno,
                          );
                          // calling the manipulation value
                          paybuttonstatus.updateButton();
                          Pay.handlePaymentInitialization();
                        }
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: const Offset(5, 5),
                            ),
                          ],
                          color: Colors.green,
                        ),
                        child: paybuttonstatus.buttonStatus == 'Pay'
                            ? Center(
                                child: Text(
                                  "${paybuttonstatus.buttonStatus} ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                    Text(
                                      "${paybuttonstatus.buttonStatus} ",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ]),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
//           ElevatedButton(
//               onPressed: () {
//                 PaymentManipulation Pay = PaymentManipulation(
//                     amount: _amount,
//                     context: context,
//                     userPhoneNumber: _mobileNumber,
//                     useremail: _useremail);
// // send via the bluetooth tokens
//                 Pay.sendBlueTOKENS();
//               },
//               child: Text('Send bluetooth')),

          // ElevatedButton(
          //   onPressed: () {
          //     localDb.DeleteAllPayments();
          //   },
          //   child: Text('Delete all'),
          // ),

          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              Get.to(() => Paybyphone());
            },
            child: Container(
                height: height * 0.06,
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(5, 5),
                    ),
                  ],
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    'Pay by phone ',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          SizedBox(
            height: height * 0.05,
          ),

          Expanded(
            child: Container(
              width: width * 0.9,
              // height: height * 0.6,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border(bottom: BorderSide()),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.04,
                        ),
                        const Text(
                          'Statement',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: width * 0.55,
                        ),
                        const Icon(Icons.checklist)
                      ],
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<DbController>(
                      init: DbController(),
                      initState: (_) {},
                      builder: (_) {
                        return fetchedPayments.isEmpty
                            ? Center(
                                child: Text(
                                  'No Payments yet!',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            : ListView.builder(
                                itemCount: fetchedPayments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return statementBox(
                                    height: height,
                                    width: width,
                                    amount: fetchedPayments[index]['Amount'],
                                    date: fetchedPayments[index]['Time'],
                                    TransactionId: fetchedPayments[index]
                                        ['TransactionID'],
                                    tokens: fetchedPayments[index]['Tokens'],
                                  );
                                },
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
