import 'package:flutter/material.dart';
import 'package:hackoverflow/auth/logout.dart';
import 'package:hackoverflow/screen/patient/component/paitentnavbar';
import 'package:hackoverflow/screen/patient/paitentappoiment.dart';
import 'package:hackoverflow/screen/patient/paitenthomepage.dart';
import 'package:hackoverflow/screen/patient/paitentseealldoctor.dart';
import 'package:intl/intl.dart';

class PatientProfilePage extends StatefulWidget {
  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  int _currentNavIndex = 3; // Profile is the fourth tab (index 3)

  // Sample patient data
  Map<String, dynamic> _patientData = {
    'name': 'John Smith',
    'email': 'john.smith@example.com',
    'age': 35,
    'gender': 'Male',
    'contact': '+1 (555) 123-4567',
    'bloodGroup': 'O+',
    'address': '123 Main Street, Anytown, CA 12345',
    'profileImage': null, // This would be an image path or URL
  };

  // Sample appointment history
  final List<Map<String, dynamic>> _appointmentHistory = [
    {
      'doctorName': 'Dr. Sarah Johnson',
      'specialty': 'Cardiology',
      'date': '2025-05-05',
      'time': '10:30 AM',
      'status': 'Completed',
    },
    {
      'doctorName': 'Dr. Michael Chen',
      'specialty': 'Dermatology',
      'date': '2025-04-20',
      'time': '02:00 PM',
      'status': 'Completed',
    },
    {
      'doctorName': 'Dr. Emily Rodriguez',
      'specialty': 'Neurology',
      'date': '2025-05-15',
      'time': '09:00 AM',
      'status': 'Upcoming',
    },
  ];

  // Controllers for editing profile
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _contactController;
  String _selectedGender = 'Male';
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _patientData['name']);
    _ageController =
        TextEditingController(text: _patientData['age'].toString());
    _contactController = TextEditingController(text: _patientData['contact']);
    _selectedGender = _patientData['gender'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = PatientHomePage();
        break;
      case 1:
        page = PatientBookAppointmentPage();
        break;
      case 2:
        // Replace with your actual doctor list page
        page = PatientDoctorListPage();
        break;
      case 3:
        // Replace with your actual profile page
        page = PatientProfilePage();
        return;
      default:
        page = PatientHomePage();

        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _saveProfile() {
    // Validate inputs
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Update patient data
    setState(() {
      _patientData['name'] = _nameController.text;
      _patientData['age'] =
          int.tryParse(_ageController.text) ?? _patientData['age'];
      _patientData['gender'] = _selectedGender;
      _patientData['contact'] = _contactController.text;
      _isEditing = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveProfile,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),

            SizedBox(height: 20),

            // Profile Details
            _isEditing ? _buildEditProfileForm() : _buildProfileDetails(),

            SizedBox(height: 20),

            // Appointment History
            _buildAppointmentHistory(),

            SizedBox(height: 20),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  LogoutDialog.show(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomPatientNavBar(
        currentIndex: _currentNavIndex,
        onTap: _navigateToPage,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          // Name and Email
          Text(
            _patientData['name'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _patientData['email'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildInfoItem(
              'Age', '${_patientData['age']} years', Icons.calendar_today),
          _buildInfoItem('Gender', _patientData['gender'], Icons.person),
          _buildInfoItem('Contact', _patientData['contact'], Icons.phone),
          _buildInfoItem(
              'Blood Group', _patientData['bloodGroup'], Icons.bloodtype),
          _buildInfoItem('Address', _patientData['address'], Icons.location_on),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Personal Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          // Name Field
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Age Field
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Age',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Gender Dropdown
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              labelText: 'Gender',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: _genderOptions.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedGender = value;
                });
              }
            },
          ),
          SizedBox(height: 16),

          // Contact Field
          TextField(
            controller: _contactController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Contact Number',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Cancel Button
          TextButton(
            onPressed: () {
              setState(() {
                // Reset controllers to original values
                _nameController.text = _patientData['name'];
                _ageController.text = _patientData['age'].toString();
                _contactController.text = _patientData['contact'];
                _selectedGender = _patientData['gender'];
                _isEditing = false;
              });
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          // Appointment List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _appointmentHistory.length,
            itemBuilder: (context, index) {
              final appointment = _appointmentHistory[index];
              final DateTime appointmentDate =
                  DateTime.parse(appointment['date']);
              final String formattedDate =
                  DateFormat('MMM d, yyyy').format(appointmentDate);

              final bool isUpcoming = appointment['status'] == 'Upcoming';
              final Color statusColor = isUpcoming ? Colors.blue : Colors.green;

              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appointment['doctorName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              appointment['status'],
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        appointment['specialty'],
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(formattedDate),
                          SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(appointment['time']),
                        ],
                      ),
                      if (isUpcoming)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Handle reschedule
                                },
                                child: Text('Reschedule'),
                              ),
                              SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  // Handle cancel
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
