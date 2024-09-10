import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
//import 'week_data_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedWeek = Provider.of<WeekProvider>(context).selectedWeek;

    if (selectedWeek == null) {
      return const Scaffold(
        body: Center(
          child: Text("No week selected"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedWeek.fruit} 💖'),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.pink.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/baby.png', height: 150), // Replace with the baby image asset
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewProgress');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('View Progress'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // Navigate to the next week view
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.pink.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Next Week'),
            ),
          ],
        ),
      ),
    );
  }
}
