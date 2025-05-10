import 'package:flutter/material.dart';
import 'package:hackoverflow/screen/patient/component/paitentnavbar';
import 'package:hackoverflow/screen/patient/paitenthomepage.dart';
import 'package:hackoverflow/screen/patient/paitentprofilepage.dart';
import 'package:hackoverflow/screen/patient/paitentseealldoctor.dart';
import 'package:intl/intl.dart'; // Add this package to pubspec.yaml

class PatientBookAppointmentPage extends StatefulWidget {
  @override
  _PatientBookAppointmentPageState createState() =>
      _PatientBookAppointmentPageState();
}

class _PatientBookAppointmentPageState
    extends State<PatientBookAppointmentPage> {
  int _currentNavIndex = 1;

  // Selected values
  String _selectedSpecialty = 'Cardiology';
  DateTime _selectedDate = DateTime.now().add(Duration(days: 1));
  String _selectedTimeSlot = '';
  String _selectedDoctor = '';

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _reasonController = TextEditingController();

  // Lists of data
  final List<String> specialties = [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Psychiatry',
    'Radiology',
    'Surgery',
    'Other'
  ];

  // Map of doctors by specialty
  final Map<String, List<Map<String, dynamic>>> doctorsBySpecialty = {
    'Cardiology': [
      {'name': 'Dr. Sarah Johnson', 'rating': 4.9, 'experience': '8 years'},
      {'name': 'Dr. Michael Chen', 'rating': 4.7, 'experience': '12 years'},
    ],
    'Dermatology': [
      {'name': 'Dr. Emily Rodriguez', 'rating': 4.8, 'experience': '10 years'},
      {'name': 'Dr. David Kim', 'rating': 4.6, 'experience': '7 years'},
    ],
    'Neurology': [
      {'name': 'Dr. James Wilson', 'rating': 4.9, 'experience': '15 years'},
      {'name': 'Dr. Lisa Patel', 'rating': 4.8, 'experience': '9 years'},
    ],
    'Orthopedics': [
      {'name': 'Dr. Robert Smith', 'rating': 4.7, 'experience': '14 years'},
      {'name': 'Dr. Maria Garcia', 'rating': 4.8, 'experience': '11 years'},
    ],
    'Pediatrics': [
      {'name': 'Dr. Jennifer Lee', 'rating': 4.9, 'experience': '12 years'},
      {'name': 'Dr. Thomas Brown', 'rating': 4.7, 'experience': '8 years'},
    ],
    'Psychiatry': [
      {'name': 'Dr. Daniel Taylor', 'rating': 4.8, 'experience': '13 years'},
      {'name': 'Dr. Sophia Martinez', 'rating': 4.6, 'experience': '9 years'},
    ],
    'Radiology': [
      {'name': 'Dr. William Clark', 'rating': 4.7, 'experience': '11 years'},
      {'name': 'Dr. Olivia Wright', 'rating': 4.8, 'experience': '7 years'},
    ],
    'Surgery': [
      {'name': 'Dr. Richard Harris', 'rating': 4.9, 'experience': '16 years'},
      {'name': 'Dr. Emma Lewis', 'rating': 4.8, 'experience': '10 years'},
    ],
    'Other': [
      {'name': 'Dr. Joseph Allen', 'rating': 4.7, 'experience': '9 years'},
      {'name': 'Dr. Ava Turner', 'rating': 4.6, 'experience': '8 years'},
    ],
  };

  // Available time slots
  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM'
  ];
  void _navigateToPage(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = PatientHomePage();
        break;
      case 1:
        page = PatientBookAppointmentPage();
        return;
      case 2:
        // Replace with your actual doctor list page
        page = PatientDoctorListPage();
        break;
      case 3:
        // Replace with your actual profile page
        page = PatientProfilePage();
        ;
        break;
      default:
        page = PatientHomePage();

        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Book Appointment'),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Select Specialty'),
                  SizedBox(height: 8),
                  _buildSpecialtySelector(),
                  SizedBox(height: 24),
                  _buildSectionTitle('Select Doctor'),
                  SizedBox(height: 8),
                  _buildDoctorSelector(),
                  SizedBox(height: 24),
                  _buildSectionTitle('Select Date'),
                  SizedBox(height: 8),
                  _buildDateSelector(),
                  SizedBox(height: 24),
                  _buildSectionTitle('Select Time'),
                  SizedBox(height: 8),
                  _buildTimeSlotSelector(),
                  SizedBox(height: 24),
                  _buildSectionTitle('Reason for Visit'),
                  SizedBox(height: 8),
                  _buildReasonField(),
                  SizedBox(height: 32),
                  _buildBookButton(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomPatientNavBar(
            currentIndex: _currentNavIndex,
            onTap: (index) {
              if (index != _currentNavIndex) {
                _navigateToPage(index);
              }
            }));
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSpecialtySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedSpecialty,
          items: specialties.map((String specialty) {
            return DropdownMenuItem<String>(
              value: specialty,
              child: Text(specialty),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedSpecialty = newValue;
                _selectedDoctor =
                    ''; // Reset selected doctor when specialty changes
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDoctorSelector() {
    final doctors = doctorsBySpecialty[_selectedSpecialty] ?? [];

    return Column(
      children: doctors.map((doctor) {
        final isSelected = _selectedDoctor == doctor['name'];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDoctor = doctor['name'];
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _selectedSpecialty,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${doctor['rating']}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 16),
                          Icon(
                            Icons.work,
                            color: Colors.blue,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            doctor['experience'],
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Radio<String>(
                  value: doctor['name'],
                  groupValue: _selectedDoctor,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedDoctor = value ?? '';
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.blue,
            ),
            SizedBox(width: 12),
            Text(
              DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTimeSlot = ''; // Reset time slot when date changes
      });
    }
  }

  Widget _buildTimeSlotSelector() {
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: timeSlots.map((time) {
          final isSelected = _selectedTimeSlot == time;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeSlot = time;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected ? Colors.blue : Colors.white,
              ),
              child: Center(
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReasonField() {
    return TextFormField(
      controller: _reasonController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Briefly describe your symptoms or reason for visit',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a reason for your visit';
        }
        return null;
      },
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_validateForm()) {
            _bookAppointment();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    // Check if all required fields are filled
    if (_selectedDoctor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a doctor')),
      );
      return false;
    }

    if (_selectedTimeSlot.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time slot')),
      );
      return false;
    }

    return _formKey.currentState?.validate() ?? false;
  }

  void _bookAppointment() {
    // Here you would typically send the appointment data to your backend
    // For now, we'll just show a success dialog

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Appointment Booked'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your appointment has been successfully booked:'),
            SizedBox(height: 16),
            _buildAppointmentDetail('Doctor', _selectedDoctor),
            _buildAppointmentDetail('Specialty', _selectedSpecialty),
            _buildAppointmentDetail(
                'Date', DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate)),
            _buildAppointmentDetail('Time', _selectedTimeSlot),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate back to home or appointment list
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
