import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'week_provider.dart';

class UserInputScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController weekController = TextEditingController();

  UserInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            _buildTextField('Week pregnant', weekController, isNumber: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int week = int.tryParse(weekController.text) ?? 1;
                Provider.of<WeekProvider>(context, listen: false)
                    .selectWeekByWeek(week); // Implement selectWeekByWeek in WeekProvider
                Navigator.pushNamed(context, '/home');
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
}
