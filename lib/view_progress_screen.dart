import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
//import 'week_data_model.dart';

class ViewProgressScreen extends StatelessWidget {
  const ViewProgressScreen({super.key});

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.pink.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/baby.png', height: 150), // Baby image
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard('Size', selectedWeek.size, Colors.orange.shade100),
                      _buildInfoCard('Fruit', selectedWeek.fruit, Colors.blue.shade100),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSection('Baby Growth', selectedWeek.babyGrowth, Colors.pink.shade100),
              _buildSection('Mother\'s Symptoms', selectedWeek.motherSymptoms, Colors.blue.shade100),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to next week
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                   'Next Week',
                   style: TextStyle(
                     color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, Color color) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        '$title: $content',
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSection(String title, String content, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
