// lib/widgets/logout_dialog.dart
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String logoutText;

  const LogoutDialog({
    Key? key,
    this.title = 'Logout',
    this.content = 'Are you sure you want to logout?',
    this.cancelText = 'Cancel',
    this.logoutText = 'Logout',
  }) : super(key: key);

  /// Shows the logout dialog
  static Future<bool?> show(
    BuildContext context, {
    String title = 'Logout',
    String content = 'Are you sure you want to logout?',
    String cancelText = 'Cancel',
    String logoutText = 'Logout',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => LogoutDialog(
        title: title,
        content: content,
        cancelText: cancelText,
        logoutText: logoutText,
      ),
    );
  }

  // Handles the logout process
  void _performLogout(BuildContext context) {
    // Clear user data, tokens, etc.
    // Example:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();

    // Navigate to login page and clear navigation stack
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login', // Use your login route name
      (route) => false,
    );

    // Alternative if you're not using named routes:
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    //   (route) => false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            _performLogout(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(logoutText),
        ),
      ],
    );
  }
}
