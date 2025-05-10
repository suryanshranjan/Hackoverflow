import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/doctor.webp'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Dr. Harshit Masiwal',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Doctor | Specialist in Cardiology',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),

              // Menu Items
              _buildMenuItem(Icons.history, 'History'),
              _buildMenuItem(Icons.person_outline, 'Personal Details'),
              _buildMenuItem(Icons.location_on_outlined, 'Location'),
              _buildMenuItem(Icons.payment_outlined, 'Payment Method'),
              _buildMenuItem(Icons.settings_outlined, 'Settings'),
              _buildMenuItem(Icons.help_outline, 'Help'),

              // Logout Button
              const Divider(thickness: 1, color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Add logout functionality here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build menu items
  Widget _buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF6D9EEB), // Icon color
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
        onTap: () {
          // Add navigation functionality here
        },
      ),
    );
  }
}
