import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'week_provider.dart';
import 'user_input_screen.dart';
import 'home_screen.dart';
import 'view_progress_screen.dart';
import 'login_screen.dart'; // Create a separate screen for login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeekProvider()..loadWeeksData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Tracker',
      theme: ThemeData(
        primaryColor: Colors.pink.shade300,
        scaffoldBackgroundColor: Colors.pink.shade50,
        fontFamily: 'Arial',
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/', // Check if user is logged in
      routes: {
        '/login': (context) => const LoginScreen(), // Create a LoginScreen for user authentication
        '/': (context) => const UserInputScreen(),
        '/home': (context) => const HomeScreen(),
        '/viewProgress': (context) => const ViewProgressScreen(),
      },
    );
  }
}
