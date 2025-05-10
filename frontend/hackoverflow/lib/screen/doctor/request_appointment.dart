import 'package:flutter/material.dart';
import './components/RequestCard.dart';

class RequestAppointmentPage extends StatelessWidget {
  const RequestAppointmentPage({super.key});

  Future<List<Map<String, String>>> _fetchRequests() async {
    await Future.delayed(const Duration(seconds: 0));

    return [
      {
        'name': 'Alice Johnson',
        'reason': 'Chest Pain Consultation',
        'requestedTime': 'Today, 4:30 PM',
        'imageUrl':
            'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvczc3LW1ja2luc2V5LTc2MTEtcG9tXzMuanBn.jpg',
      },
      {
        'name': 'Bob Smith',
        'reason': 'Heart Checkup',
        'requestedTime': 'Tomorrow, 10:00 AM',
        'imageUrl':
            'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvczc3LW1ja2luc2V5LTc2MTEtcG9tXzMuanBn.jpg',
      },
      {
        'name': 'Charlie Brown',
        'reason': 'General Checkup',
        'requestedTime': 'Tomorrow, 12:00 PM',
        'imageUrl':
            'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvczc3LW1ja2luc2V5LTc2MTEtcG9tXzMuanBn.jpg',
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _fetchRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No requests available.'));
          }

          final requests = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Incoming Appointment Requests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RequestCard(
                          name: request['name']!,
                          reason: request['reason']!,
                          requestedTime: request['requestedTime']!,
                          imageUrl: request['imageUrl']!,
                          onAccept: () {
                            // Handle accept action
                          },
                          onReject: () {
                            // Handle reject action
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
