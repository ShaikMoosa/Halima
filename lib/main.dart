import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
import 'user_input_screen.dart';
import 'home_screen.dart';
import 'view_progress_screen.dart';

void main() {
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
        fontFamily: 'Arial', // Use custom font if needed
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => UserInputScreen(),
        '/home': (context) => const HomeScreen(),
        '/viewProgress': (context) => const ViewProgressScreen(),
      },
    );
  }
}
