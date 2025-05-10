import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String name;
  final String reason;
  final String requestedTime;
  final String imageUrl; // Added parameter for image URL or asset
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const RequestCard({
    Key? key,
    required this.name,
    required this.reason,
    required this.requestedTime,
    required this.imageUrl, // Accept image URL/asset path
    this.onAccept,
    this.onReject,
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
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(imageUrl), // Use image URL from the API
            radius: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800])),
                const SizedBox(height: 4),
                Text(reason, style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 6),
                Text(requestedTime,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: onAccept,
                      child: const Text("Accept"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(80, 36),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onReject,
                      child: const Text("Reject"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size(80, 36),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
