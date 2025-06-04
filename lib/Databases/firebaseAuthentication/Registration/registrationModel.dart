import 'package:cloud_firestore/cloud_firestore.dart';

class Registrationmodel {
  final name;
  final email;
  final Meter_No;
  final ApartmentId;
  final Phonenumber;

  //constructor for
  Registrationmodel({
    required this.name,
    required this.email,
    required this.Meter_No,
    required this.ApartmentId,
    required this.Phonenumber,
  });
  //
  //
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addUser() async {
    // Create a new user with a map
    Map<String, dynamic> user = {
      'name': name,
      'email': email,
      'Meter_NO': Meter_No,
      'ApartmentID': ApartmentId,
      'Phonenumber': Phonenumber,
      'password': '12345678'
    };

    try {
      // Add to 'users' collection (auto-generated ID)
      await firestore.collection('users').add(user);
      print('Data added successfully ');
    } catch (e) {
      print('cant add to database $e');
    }
  }
}
