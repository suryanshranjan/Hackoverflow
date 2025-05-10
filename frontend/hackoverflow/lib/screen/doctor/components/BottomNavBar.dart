import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Appointments'),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_time), label: 'Requests'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notifications'),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.teal[600],
      unselectedItemColor: Colors.grey,
      onTap: onTap,
    );
  }
}
