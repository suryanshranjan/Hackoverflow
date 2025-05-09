import 'package:flutter/material.dart';
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
      home: const SplashScreen(),
    );
  }
}

// The following is for reference to show how the screens connect together
// You should have separate files for these classes rather than including them here

/*
// In splashscreen.dart, make sure to update the navigation:
Future.delayed(const Duration(seconds: 6), () {
  if (mounted) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const RoleSelectionScreen(),
      ),
    );
  }
});

// In roleselectionscreen.dart, your navigation methods should point to actual screens:
// For Doctor role:
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const DoctorDashboard(),
  ),
);

// For Patient role:
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const PatientDashboard(),
  ),
);
*/
