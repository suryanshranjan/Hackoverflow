import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackoverflow/screen/patient/component/paitentnavbar';
import 'package:hackoverflow/screen/patient/paitentappoiment.dart';
import 'package:hackoverflow/screen/patient/paitentprofilepage.dart';
import 'package:hackoverflow/screen/patient/paitentseealldoctor.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int _currentNavIndex = 0;
  final String userName =
      "John"; // Replace with actual user name from your data

  // List of medical specialties
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

  // List of health tips for carousel
  final List<Map<String, dynamic>> healthTips = [
    {
      'title': 'Staying Hydrated',
      'subtitle': 'Drink at least 8 glasses of water daily for optimal health',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'title': 'Regular Exercise',
      'subtitle': '30 minutes of exercise daily improves overall health',
      'icon': Icons.fitness_center,
      'color': Colors.green,
    },
    {
      'title': 'Healthy Sleep',
      'subtitle': 'Aim for 7-8 hours of quality sleep every night',
      'icon': Icons.bedtime,
      'color': Colors.indigo,
    },
    {
      'title': 'Balanced Diet',
      'subtitle': 'Include fruits and vegetables in every meal',
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
  ];

  // List of upcoming appointments (you would fetch this from your backend)
  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      'doctorName': 'Dr. Sarah Johnson',
      'specialty': 'Cardiology',
      'date': 'May 12, 2025',
      'time': '10:30 AM',
    },
  ];
  void _navigateToPage(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = PatientHomePage();
        return;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DocConnect'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildGreetingSection(),
              ),

              SizedBox(height: 8),

              // Health Tips Carousel
              _buildHealthTipsCarousel(),

              SizedBox(height: 24),

              // Specialties Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildSpecialtiesSection(),
              ),

              SizedBox(height: 24),

              // Upcoming Appointment Section (if any)
              if (upcomingAppointments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildUpcomingAppointmentSection(),
                ),

              SizedBox(height: 24),

              // Dashboard Actions
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildDashboardActions(),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: CustomPatientNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index != _currentNavIndex) {
            _navigateToPage(index);
          }
        },
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $userName!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'How are you feeling today?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTipsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: healthTips.map((tip) {
        return _buildTipCarouselItem(
            tip['title'], tip['subtitle'], tip['icon'], tip['color']);
      }).toList(),
    );
  }

  Widget _buildTipCarouselItem(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: Icon(
              icon,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to health tip details page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: color,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Read More'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find Doctors By Specialty',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specialties.length,
            itemBuilder: (context, index) {
              return _buildSpecialtyButton(specialties[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialtyButton(String specialty) {
    return GestureDetector(
        onTap: () {
          // Navigate to doctor list filtered by this specialty
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDoctorListPage(),
            ),
          );
        },
        child: Container(
          width: 100,
          margin: EdgeInsets.only(right: 12),
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForSpecialty(specialty),
                  color: Colors.blue,
                  size: 32,
                ),
              ),
              SizedBox(height: 8),
              Text(
                specialty,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }

  IconData _getIconForSpecialty(String specialty) {
    // Return appropriate icons for each specialty
    switch (specialty) {
      case 'Cardiology':
        return Icons.favorite;
      case 'Dermatology':
        return Icons.face;
      case 'Neurology':
        return Icons.psychology;
      case 'Orthopedics':
        return Icons.accessibility_new;
      case 'Pediatrics':
        return Icons.child_care;
      case 'Psychiatry':
        return Icons.mood;
      case 'Radiology':
        return Icons.radio;
      case 'Surgery':
        return Icons.medical_services;
      default:
        return Icons.local_hospital;
    }
  }

  Widget _buildUpcomingAppointmentSection() {
    final appointment = upcomingAppointments[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Appointment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['doctorName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        appointment['specialty'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
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
                          Text(
                            appointment['date'],
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(
                            appointment['time'],
                            style: TextStyle(
                              fontSize: 14,
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
      ],
    );
  }

  Widget _buildDashboardActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildActionCard(
              'Book Appointment',
              Icons.calendar_today,
              Colors.blue,
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientBookAppointmentPage()),
                );
              },
            ),
            _buildActionCard(
              'Top Doctors',
              Icons.star,
              Colors.orange,
              () {
                // Navigate to doctor list with no filter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientDoctorListPage()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
