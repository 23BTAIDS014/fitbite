import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;

  const DashboardScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: const Text('FitBite Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Welcome, ${userName.isEmpty ? 'Friend' : userName} 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Here’s your progress today:',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
            const SizedBox(height: 24),


            _statCard(
              icon: Icons.local_fire_department,
              title: 'Calories',
              value: '1,250 kcal',
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 16),
            _statCard(
              icon: Icons.water_drop,
              title: 'Water Intake',
              value: '1.5 L',
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            _statCard(
              icon: Icons.fastfood,
              title: 'Next Meal',
              value: 'Lunch at 1 PM',
              color: Colors.teal,
            ),

            const SizedBox(height: 28),

            ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to meal‑planning screen
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Plan My Meals'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(38),
          child: Icon(icon, color: color),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
