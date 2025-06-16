import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwavepaymenttesting/pages/adminfolder/Adminpage.dart';
import 'package:flutterwavepaymenttesting/pages/dashboardpage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginmodel {
  //final String name;
  final String email;
  final String password;
  final context;

  Loginmodel(
      {required this.email, required this.password, required this.context});

  void Login() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('✅ Login success');

        _showLoadingDialog(context, "Please wait....", "logging in...");
        // Get the document data
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        String mterno = data['Meter_NO'] ?? 'Unknown';
        String Phonenumber = data['Phonenumber'] ?? 'Unkown';
        String name = data['name'] ?? 'Unknown';

        // Save session (optional)  Phonenumber
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', name);
        await prefs.setString('Meter_NO', mterno);
        await prefs.setString('Phonenumber', Phonenumber);
        await prefs.setString('email', email);

        if (email == 'emmanuelmeltrides@gmail.com') {
          await Get.to(() => AdminDashboard());
        } else {
          //
          await Get.to(() => Dashboardpage());
        }
      } else {
        print(' Wrong credentials');
        _showLoadingDialog(context, "error", " please check your connection ");
      }
    } catch (e) {
      print(' Error fetching users: $e');
      _showLoadingDialog(context, "error", " please check your connection ");
    }
  }
}

void _showLoadingDialog(BuildContext context, mesaage1, messsage2) {
  // Show the dialog
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(mesaage1),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(messsage2),
          ],
        ),
      );
    },
  );

  // Close the dialog after 20 seconds
  // Timer(Duration(seconds: 20), () {
  //   //Navigator.of(context).pop(); // Close the dialog
  //   // Optional: show a success message or navigate
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //   SnackBar(content: Text('waited to long please check your connection!')),
  //   // );
  // });
}
