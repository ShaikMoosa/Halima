import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
import 'week_data_model.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weeksData = Provider.of<WeekProvider>(context).weeksData;

    return Scaffold(
      body: weeksData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              scrollDirection: Axis.vertical, // Set vertical scroll direction
              itemCount: weeksData.length,
              itemBuilder: (context, index) {
                final weekData = weeksData[index];
                return _buildWeekContainer(context, weekData);
              },
            ),
    );
  }

  Widget _buildWeekContainer(BuildContext context, WeekData weekData) {
    return Container(
      color: Colors.pink.shade50,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/baby.png', height: 150), // Replace with baby image asset
            const SizedBox(height: 20),
            Text(
              '${weekData.fruit} 💖',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Week ${weekData.weekRange}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<WeekProvider>(context, listen: false).selectWeek(weekData);
                Navigator.pushNamed(context, '/viewProgress');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                  'View Progress',
                 style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
