import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Profile Header Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/doctor.webp'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Dr. Harshit Masiwal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildMenuItem(Icons.history, 'History'),
            _buildMenuItem(Icons.person_outline, 'Personal Details'),
            _buildMenuItem(Icons.location_on_outlined, 'Location'),
            _buildMenuItem(Icons.payment_outlined, 'Payment Method'),
            _buildMenuItem(Icons.settings_outlined, 'Settings'),
            _buildMenuItem(Icons.help_outline, 'Help'),
            // Logout Button
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Add logout functionality here
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build menu items
  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Add navigation functionality here
      },
    );
  }
}
