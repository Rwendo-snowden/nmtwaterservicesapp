import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDetailsPage extends StatelessWidget {
  // Sample data

  TransactionDetailsPage({
    required this.TransactionDate,
    required this.amount,
    required this.token,
    required this.transactionId,
  });

  String TransactionDate = "";
  final String amount;
  final String transactionId;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Details"),
        centerTitle: true,
        // backgroundColor: Colors.teal,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailRow(label: "Date", value: TransactionDate),
                Divider(height: 30),
                DetailRow(label: "Amount", value: '$amount TZS'),
                Divider(height: 30),
                DetailRow(label: "Transaction ID", value: transactionId),
                Divider(height: 30),
                DetailRow(label: "Token", value: token),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateFormat {}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
