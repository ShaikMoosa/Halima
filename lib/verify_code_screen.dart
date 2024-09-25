import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/reset_password_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email; // Pass the email to this screen

  VerifyCodeScreen({required this.email});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _codeController = TextEditingController();
  String _message = '';

  Future<void> _verifyCode() async {
    // Replace this with your verification logic (e.g., sending and verifying codes)
    if (_codeController.text == "12345") { // Replace with actual verification
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(email: widget.email),
        ),
      );
    } else {
      setState(() {
        _message = 'Invalid code. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We sent a reset link to ${widget.email}. Enter the 5-digit code that was included in the email.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              maxLength: 5,
              decoration: InputDecoration(
                labelText: 'Enter Code',
                errorText: _message.isNotEmpty ? _message : null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyCode,
              child: Text('Verify Code'),
            ),
            TextButton(
              onPressed: () {
                // Optionally handle resending the code
              },
              child: Text('Haven’t got the email? Resend email'),
            ),
          ],
        ),
      ),
    );
  }
}
