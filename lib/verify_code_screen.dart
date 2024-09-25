import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  VerifyCodeScreen({required this.email});

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _codeController = TextEditingController();
  String _message = '';
  final _auth = FirebaseAuth.instance; // Keep the FirebaseAuth instance

  Future<void> _verifyCode() async {
    try {
      // Simulating the process of code verification.
      // Replace this with actual Firebase verification logic, like email action codes or phone verification.
      var user = _auth.currentUser;
      if (user != null) {
        await user.reload(); // Reload to ensure the user info is updated
        if (user.emailVerified) { // Check if email is verified
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(email: widget.email),
            ),
          );
        } else {
          setState(() {
            _message = 'Please verify your email before proceeding.';
          });
        }
      } else {
        setState(() {
          _message = 'User not found. Please log in again.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Verification failed. Please try again later.';
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
                // Implement code resend functionality here
              },
              child: Text('Haven’t got the email? Resend email'),
            ),
          ],
        ),
      ),
    );
  }
}
