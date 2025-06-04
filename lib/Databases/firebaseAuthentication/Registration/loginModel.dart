import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwavepaymenttesting/pages/adminfolder/Adminpage.dart';
import 'package:flutterwavepaymenttesting/pages/dashboardpage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginmodel {
  final String name;
  final String password;

  Loginmodel({required this.name, required this.password});

  void Login() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: name)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('✅ Login success');

        // Get the document data
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        String mterno = data['Meter_NO'] ?? 'Unknown';
        String Phonenumber = data['Phonenumber'] ?? 'Unkown';
        String email = data['email'] ?? 'Unknown';

        // Save session (optional)  Phonenumber
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', name);
        await prefs.setString('Meter_NO', mterno);
        await prefs.setString('Phonenumber', Phonenumber);
        await prefs.setString('email', email);

        if (name == 'admin') {
          await Get.to(() => AdminDashboard());
        } else {
          //
          await Get.to(() => Dashboardpage());
        }
      } else {
        print(' Wrong credentials');
      }
    } catch (e) {
      print(' Error fetching users: $e');
    }
  }
}
