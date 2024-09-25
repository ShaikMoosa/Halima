import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/verify_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _message = '';

Future<void> _resetPassword() async {
  try {
    await _auth.sendPasswordResetEmail(
      email: _emailController.text.trim(),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerifyCodeScreen(email: _emailController.text.trim()),
      ),
    );
    setState(() {
      _message = 'Password reset email sent';
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
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Your Email',
                errorText: _message.isNotEmpty ? _message : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
