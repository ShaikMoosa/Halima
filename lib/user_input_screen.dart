import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';
import 'week_data_model.dart'; // Import the WeekData model

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  UserInputScreenState createState() => UserInputScreenState();
}

class UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  int selectedWeek = 1; // Default value for selected week

  @override
  Widget build(BuildContext context) {
    final weeksData = Provider.of<WeekProvider>(context).weeksData;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField('Your name', nameController),
            const SizedBox(height: 10),
            _buildTextField('Baby nickname', nicknameController),
            const SizedBox(height: 10),
            _buildWeekDropdown(weeksData),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logging to check button press
                print('Next button pressed. Selected week: $selectedWeek');

                // Check if weeksData is available
                if (weeksData.isNotEmpty) {
                  // Select the week and navigate to HomeScreen
                  Provider.of<WeekProvider>(context, listen: false)
                      .selectWeekByWeek(selectedWeek);

                  // Navigate to the HomeScreen with the selected week
                  Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: selectedWeek, // Pass the selected week as an argument
                  );
                } else {
                  // Show an error message if weeksData is not available
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a valid week.")),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildWeekDropdown(List<WeekData> weeksData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: selectedWeek,
          items: List.generate(weeksData.length, (index) {
            int startWeek = int.parse(weeksData[index].weekRange.split('-').first);
            return DropdownMenuItem<int>(
              value: startWeek,
              child: Text('Week $startWeek'),
            );
          }),
          onChanged: (int? newValue) {
            setState(() {
              selectedWeek = newValue!;
              print('Selected week updated: $selectedWeek'); // Log the selected week
            });
          },
          hint: const Text('Select week pregnant'),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
          dropdownColor: Colors.pink.shade50,
        ),
      ),
    );
  }
}
