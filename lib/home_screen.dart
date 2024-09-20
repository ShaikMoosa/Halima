import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
import 'week_data_model.dart';
//import 'dart:developer' as developer; // Import for logging

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int initialPageIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final weeksData = Provider.of<WeekProvider>(context, listen: false).weeksData;
    final int selectedWeek = ModalRoute.of(context)?.settings.arguments as int? ?? 1;

    // Calculate the initial page index based on the selected week.
    initialPageIndex = weeksData.indexWhere((weekData) {
      final weekRange = weekData.weekRange.split('-');
      int startWeek = int.parse(weekRange.first);
      int endWeek = int.parse(weekRange.last);
      return selectedWeek >= startWeek && selectedWeek <= endWeek;
    });

    _pageController = PageController(initialPage: initialPageIndex >= 0 ? initialPageIndex : 0);

    // Trigger auto-scroll after a short delay of 0.3 seconds
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          initialPageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weeksData = Provider.of<WeekProvider>(context).weeksData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: weeksData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
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
            ClipOval(
              child: Image.asset(
                'assets/${weekData.fruit.toLowerCase()}.png',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 150),
              ),
            ),
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
                Provider.of<WeekProvider>(context, listen: false)
                    .selectWeek(weekData);
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
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
