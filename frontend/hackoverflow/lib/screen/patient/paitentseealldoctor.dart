import 'package:flutter/material.dart';
import 'package:hackoverflow/screen/patient/component/paitentnavbar';
import 'package:hackoverflow/screen/patient/paitentappoiment.dart';
import 'package:hackoverflow/screen/patient/paitenthomepage.dart';
import 'package:hackoverflow/screen/patient/paitentprofilepage.dart';

class PatientDoctorListPage extends StatefulWidget {
  final String? categoryFilter;

  const PatientDoctorListPage({Key? key, this.categoryFilter})
      : super(key: key);

  @override
  _PatientDoctorListPageState createState() => _PatientDoctorListPageState();
}

class _PatientDoctorListPageState extends State<PatientDoctorListPage> {
  int _currentNavIndex = 2; // Doctor List is the third tab (index 2)
  String _searchQuery = '';
  List<String> _selectedCategories = [];

  // List of all available categories
  final List<String> _allCategories = [
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

  // Sample doctor data
  final List<Map<String, dynamic>> _allDoctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'category': 'Cardiology',
      'rating': 4.9,
      'experience': '8 years',
      'patients': '1.5k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. Michael Chen',
      'category': 'Cardiology',
      'rating': 4.7,
      'experience': '12 years',
      'patients': '2.2k+',
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Dr. Emily Rodriguez',
      'category': 'Dermatology',
      'rating': 4.8,
      'experience': '10 years',
      'patients': '1.8k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. David Kim',
      'category': 'Dermatology',
      'rating': 4.6,
      'experience': '7 years',
      'patients': '1.2k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. James Wilson',
      'category': 'Neurology',
      'rating': 4.9,
      'experience': '15 years',
      'patients': '3.0k+',
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Dr. Lisa Patel',
      'category': 'Neurology',
      'rating': 4.8,
      'experience': '9 years',
      'patients': '1.6k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. Robert Smith',
      'category': 'Orthopedics',
      'rating': 4.7,
      'experience': '14 years',
      'patients': '2.5k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. Jennifer Lee',
      'category': 'Pediatrics',
      'rating': 4.9,
      'experience': '12 years',
      'patients': '2.8k+',
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Dr. Daniel Taylor',
      'category': 'Psychiatry',
      'rating': 4.8,
      'experience': '13 years',
      'patients': '2.3k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. William Clark',
      'category': 'Radiology',
      'rating': 4.7,
      'experience': '11 years',
      'patients': '1.9k+',
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Dr. Richard Harris',
      'category': 'Surgery',
      'rating': 4.9,
      'experience': '16 years',
      'patients': '3.2k+',
      'availability': 'Available Today',
    },
    {
      'name': 'Dr. Joseph Allen',
      'category': 'Other',
      'rating': 4.7,
      'experience': '9 years',
      'patients': '1.7k+',
      'availability': 'Available Tomorrow',
    },
  ];

  @override
  void initState() {
    super.initState();
    // If a category filter was passed, select it
    if (widget.categoryFilter != null) {
      _selectedCategories = [widget.categoryFilter!];
    }
  }

  // Filter doctors based on selected categories and search query
  List<Map<String, dynamic>> get _filteredDoctors {
    return _allDoctors.where((doctor) {
      // Apply category filter
      bool matchesCategory = _selectedCategories.isEmpty ||
          _selectedCategories.contains(doctor['category']);

      // Apply search filter
      bool matchesSearch = _searchQuery.isEmpty ||
          doctor['name'].toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
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
        return;
      case 3:
        // Replace with your actual profile page
        page = PatientProfilePage();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryFilter != null
              ? '${widget.categoryFilter} Doctors'
              : 'All Doctors'),
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search doctors by name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // Category filter chips
            if (widget.categoryFilter ==
                null) // Only show filter chips if not already filtered
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _allCategories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedCategories.add(category);
                              } else {
                                _selectedCategories.remove(category);
                              }
                            });
                          },
                          selectedColor: Colors.blue.withOpacity(0.2),
                          checkmarkColor: Colors.blue,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

            // Results count
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_filteredDoctors.length} Doctors Found',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  DropdownButton<String>(
                    hint: Text('Sort by'),
                    underline: SizedBox(),
                    icon: Icon(Icons.sort),
                    onChanged: (value) {
                      // Implement sorting logic
                    },
                    items: [
                      DropdownMenuItem(value: 'rating', child: Text('Rating')),
                      DropdownMenuItem(
                          value: 'experience', child: Text('Experience')),
                    ],
                  ),
                ],
              ),
            ),

            // Doctor list
            Expanded(
              child: _filteredDoctors.isEmpty
                  ? Center(
                      child: Text(
                        'No doctors found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = _filteredDoctors[index];
                        return _buildDoctorCard(doctor);
                      },
                    ),
            ),
          ],
        ),
        bottomNavigationBar: CustomPatientNavBar(
            currentIndex: _currentNavIndex,
            onTap: (index) {
              if (index != _currentNavIndex) {
                _navigateToPage(index);
              }
            }));
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to doctor details page
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor image
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 16),
              // Doctor info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      doctor['category'],
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${doctor['rating']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.work, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(doctor['experience']),
                        SizedBox(width: 16),
                        Icon(Icons.people, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(doctor['patients']),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            doctor['availability'],
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
