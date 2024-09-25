import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email; // Pass the email to this screen

  ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance; // Keep the FirebaseAuth instance
  String _message = '';

  Future<void> _resetPassword() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      setState(() {
        _message = 'Passwords do not match';
      });
      return;
    }

    try {
      // Send password reset email again as Firebase does not support password reset directly
      await _auth.sendPasswordResetEmail(email: widget.email);

      setState(() {
        _message = 'A password reset link has been sent to your email!';
      });
    } catch (e) {
      setState(() {
        _message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set a New Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                errorText: _message.isNotEmpty ? _message : null,
              ),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: _message.isNotEmpty ? _message : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Update Password'),
            ),
            SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
