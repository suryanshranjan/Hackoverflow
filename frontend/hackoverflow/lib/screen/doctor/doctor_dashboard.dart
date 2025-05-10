import 'package:flutter/material.dart';
import 'package:hackoverflow/screen/doctor/request_appointment.dart';
import './components/AppointmentCard.dart';
import './components/ProfileGreeting.dart';
import './components/BottomNavBar.dart';
import '../doctor/ProfilePage.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const ProfileGreeting(doctorName: 'Dr. Harshit Masiwal'),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Text('Upcoming Appointments',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: const [
                    AppointmentCard(
                      name: 'John Doe',
                      specialty: 'Cardiology',
                      time: 'Today, 2:00 PM',
                      profileImage: 'assets/doctor.webp',
                    ),
                    AppointmentCard(
                      name: 'Jane Smith',
                      specialty: 'Dermatology',
                      time: 'Tomorrow, 11:00 AM',
                      profileImage: 'assets/doctor.webp',
                    ),
                    AppointmentCard(
                      name: 'Bob Johnson',
                      specialty: 'Neurology',
                      time: 'Tomorrow, 4:00 PM',
                      profileImage: 'assets/doctor.webp',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1:
        return RequestAppointmentPage();
      case 2:
        return const Center(child: Text("Patients screen coming soon..."));
      case 3:
        return ProfilePage(); //  Show ProfilePage here
      case 4:
        return const Center(child: Text("Notifications screen coming soon..."));
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: _buildBody(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
