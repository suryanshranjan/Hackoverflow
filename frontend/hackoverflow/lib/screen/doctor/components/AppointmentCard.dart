import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final int age;
  final String gender;
  final String symptoms;
  final String time;
  final String profileImage;

  const AppointmentCard({
    Key? key,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.symptoms,
    required this.time,
    this.profileImage =
        'assets/patient_avatar.png', // Default image if none is provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(profileImage), // Displaying the image
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Age: $age | Gender: $gender',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Show the popup (dialog) when tapped on "View"
              _showAppointmentDetailsDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Blue color for the button
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
            child: const Text(
              'View',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the popup dialog with detailed appointment info
  void _showAppointmentDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Details for $patientName'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      profileImage), // Displaying image in the dialog
                ),
                const SizedBox(height: 8),
                Text('Patient Name: $patientName'),
                const SizedBox(height: 8),
                Text('Age: $age'),
                const SizedBox(height: 8),
                Text('Gender: $gender'),
                const SizedBox(height: 8),
                Text('Symptoms: $symptoms'),
                const SizedBox(height: 8),
                Text('Appointment Time: $time'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
