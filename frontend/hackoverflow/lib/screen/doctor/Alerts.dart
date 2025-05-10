import 'package:flutter/material.dart';
import './components/NotificationTile.dart'; // Import NotificationTile

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Heading for Notifications
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(
                height: 16), // Space between heading and notifications list
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                // Simulating fetching notifications from an API
                future: _fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No notifications available.'));
                  }

                  final notifications = snapshot.data!;

                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationTile(
                        title: notification['title']!,
                        description: notification['description']!,
                        timestamp: notification['timestamp']!,
                        onTap: () {
                          // Show the notification details or open an alert
                          _showNotificationDetails(context, notification);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, String>>> _fetchNotifications() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 0));
    return [
      {
        'title': 'New appointment request from Dr. John.',
        'description':
            'Dr. John has requested an appointment with you for a checkup.',
        'timestamp': 'Jan 15, 2023 - 2:30 PM',
      },
      {
        'title': 'Test Results Available',
        'description': 'Your test results are now available for review.',
        'timestamp': 'Feb 10, 2023 - 11:00 AM',
      },
      {
        'title': 'New message from Dr. Alice.',
        'description':
            'Dr. Alice has sent you a message regarding your upcoming appointment.',
        'timestamp': 'Mar 5, 2023 - 4:00 PM',
      },
    ];
  }

  // Function to display notification details (e.g., in an AlertDialog)
  void _showNotificationDetails(
      BuildContext context, Map<String, String> notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notification Details'),
          content: Text(notification['description']!),
          actions: [
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
