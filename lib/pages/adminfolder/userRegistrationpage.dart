import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(label: 'Full Name', icon: Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Phone number',
                      icon: Icons.phone,
                      obscureText: true),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: 'Apartment ID',
                      icon: Icons.lock_outline,
                      obscureText: true),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromARGB(255, 63, 113, 198),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle registration
                      }
                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  // const SizedBox(height: 24),
                  // TextButton(
                  //   onPressed: () {
                  //     // Navigate to login
                  //   },
                  //   child: Text('Already have an account? Log in',
                  //       style: TextStyle(color: Colors.deepPurple)),
                  // ),
                ],
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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}
