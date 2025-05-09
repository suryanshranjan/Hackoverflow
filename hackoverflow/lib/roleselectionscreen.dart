import 'package:flutter/material.dart';
import 'package:hackoverflow/auth/login.dart';
// Assuming you have a similar login screen
// Update this import path according to your project structure

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[50]!, Colors.teal[100]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // App Logo
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.medical_services_rounded,
                    size: 60,
                    color: Colors.teal[600],
                  ),
                ),
                const SizedBox(height: 20),
                // App Name
                Text(
                  'DocConnect',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                // Subtitle
                Text(
                  'Choose your role to continue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal[700],
                  ),
                ),
                const SizedBox(height: 60),

                // Role Option Cards
                _buildRoleCard(
                  context,
                  'Doctor',
                  Icons.medical_information,
                  () => _handleRoleSelection(context, 'doctor'),
                ),
                const SizedBox(height: 20),
                _buildRoleCard(
                  context,
                  'Patient',
                  Icons.person,
                  () => _handleRoleSelection(context, 'patient'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.teal[600], size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.teal[400],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _handleRoleSelection(BuildContext context, String role) {
    // Store the selected role (using shared preferences, provider, etc. if needed)
    // This can be implemented later

    // Print the selected role for debugging
    print('Selected role: $role');

    // Navigate to your custom login screen with the selected role
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(
              role: role)), // Changed to LoginPage from your auth/login.dart
    );

    // Show a snackbar to indicate the selection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$role module will be loaded')),
    );
  }
}
