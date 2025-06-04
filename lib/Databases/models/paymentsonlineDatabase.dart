import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Addpayments {
  final transationID;
  final Meter_NO;
  final Amount;
  final Tokens;

  Addpayments({
    required this.transationID,
    required this.Meter_NO,
    this.Amount,
    this.Tokens,
  });
  //
  //make the firestore object
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AddpaymentsToDatabse() async {
    Map<String, dynamic> payment = {
      'TransactionID': '',
      'Meter_NO': '',
      'Amount': '',
      'Tokens': ''
    };

    // Add to 'users' collection (auto-generated ID)
    await firestore.collection('Payments').add(payment);
  }
}
