import 'package:flutter/material.dart';
import 'package:hackoverflow/screen/doctor/doctor_dashboard.dart';
import 'package:hackoverflow/screen/patient/paitenthomepage.dart';
import 'splashscreen.dart'; // Import your splash screen
// Make sure to create these files with the code we've already written
// import 'roleselectionscreen.dart';
// We'll handle these imports as we build more screens

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocConnect',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        // Custom theme settings for our app
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[600],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[600],
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      // Start with the splash screen, which will handle navigation to role selection
      home: DoctorDashboard(),
    );
  }
}
