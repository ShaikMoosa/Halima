import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
import 'week_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int initialPageIndex = 0;
  String babyName = 'Baby Growth'; // Default title

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final weeksData = Provider.of<WeekProvider>(context, listen: false).weeksData;
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final int selectedWeek = args['week'] ?? 1;
    babyName = args['babyName'] ?? 'Baby Growth';

    // Check if weeksData is not empty before using it
    if (weeksData.isEmpty) {
      print("Error: weeksData is empty or not loaded.");
      return;
    }

    // Calculate the initial page index based on the selected week.
    initialPageIndex = weeksData.indexWhere((weekData) {
      final weekRange = weekData.weekRange.split('-');
      int startWeek = int.parse(weekRange.first);
      int endWeek = weekRange.length > 1 ? int.parse(weekRange.last) : startWeek;
      return selectedWeek >= startWeek && selectedWeek <= endWeek;
    });

    // Check if the initial page index is valid
    if (initialPageIndex < 0 || initialPageIndex >= weeksData.length) {
      print("Error: initialPageIndex is out of range: $initialPageIndex");
      initialPageIndex = 0; // Set to the first page if out of range
    }

    _pageController = PageController(initialPage: initialPageIndex);

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
        title: Center(
          child: Text(
            babyName, // Display baby name or default title
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        backgroundColor: Colors.pink.shade50, // Optional: Set background color for the AppBar
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

                // Navigate to ViewProgressScreen with the selected WeekData
                Navigator.pushNamed(
                  context,
                  '/viewProgress',
                  arguments: weekData, // Pass the entire WeekData object as an argument
                );
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
