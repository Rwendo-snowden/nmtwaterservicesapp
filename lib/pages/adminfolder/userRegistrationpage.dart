import 'package:flutter/material.dart';
import 'package:flutterwavepaymenttesting/Databases/firebaseAuthentication/Registration/registrationModel.dart';

class RegistrationPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final apartmentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create Tenant',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 63, 113, 198),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildTextField(
              label: 'Full Name',
              icon: Icons.person,
              controller: nameController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              icon: Icons.email,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Phone number',
              icon: Icons.phone,
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Apartment ID',
              icon: Icons.lock_outline,
              controller: apartmentIdController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color.fromARGB(255, 63, 113, 198),
              ),
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final phone = phoneController.text.trim();
                final apartmentId = apartmentIdController.text.trim();

                if (name.isEmpty ||
                    email.isEmpty ||
                    phone.isEmpty ||
                    apartmentId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                // You can add more custom validation here if needed

                final registration = await Registrationmodel(
                  name: name,
                  email: email,
                  Meter_No: apartmentId, // Add if you have this data
                  ApartmentId: apartmentId,
                  Phonenumber: phone,
                );
                //register the user
                registration.addUser();
                nameController.clear();
                emailController.clear();
                phoneController.clear();
                apartmentIdController.clear();
              },
              child: Text(
                'ADD',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
