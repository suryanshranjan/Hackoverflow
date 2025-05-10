import 'package:flutter/material.dart';
import './components/AppointmentCard.dart';

class PastAppointmentsPage extends StatelessWidget {
  const PastAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Text
            const Text(
              'Past Appointments',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildAppointmentCard(
                    patientName: 'John Doe',
                    age: 28,
                    gender: 'Male',
                    symptoms: 'Fever, Cough, Headache',
                    time: 'January 15, 2023 - 2:30 PM',
                    profileImage: 'assets/doctor.webp',
                  ),
                  _buildAppointmentCard(
                    patientName: 'Emily Smith',
                    age: 34,
                    gender: 'Female',
                    symptoms: 'Nausea, Vomiting',
                    time: 'February 10, 2023 - 11:00 AM',
                    profileImage: 'assets/doctor.webp',
                  ),
                  _buildAppointmentCard(
                    patientName: 'Robert Brown',
                    age: 40,
                    gender: 'Male',
                    symptoms: 'Back Pain, Fatigue',
                    time: 'March 5, 2023 - 4:00 PM',
                    profileImage: 'assets/doctor.webp',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String patientName,
    required int age,
    required String gender,
    required String symptoms,
    required String time,
    required String profileImage,
  }) {
    return AppointmentCard(
      patientName: patientName,
      age: age,
      gender: gender,
      symptoms: symptoms,
      time: time,
      profileImage: profileImage,
    );
  }
}
