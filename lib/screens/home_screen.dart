import 'package:flutter/material.dart';
import 'package:noteapp/screens/excresize.dart';
import 'package:noteapp/screens/habit.dart';
import 'package:noteapp/screens/meal.dart';
import 'package:noteapp/screens/mood.dart';
import 'package:noteapp/screens/quote.dart';
import 'task_screen.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Daily Manager',
            style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildMenuButton(context, 'Task List', Icons.list, TaskScreen(),
                [Colors.teal, Colors.cyan]),
            _buildMenuButton(context, 'Positive Notes', Icons.note,
                NoteScreen(), [Colors.orange, Colors.deepOrangeAccent]),
            _buildMenuButton(context, 'Daily Quotes', Icons.format_quote,
                DailyQuotesScreen(), [Colors.green, Colors.lightGreenAccent]),
            _buildMenuButton(context, 'Habit Tracker', Icons.check_circle,
                HabitTrackerScreen(), [Colors.blue, Colors.lightBlueAccent]),
            _buildMenuButton(context, 'Mood Tracker', Icons.sentiment_satisfied,
                DailyMoodTrackerScreen(), [Colors.pink, Colors.purple]),
            _buildMenuButton(context, 'Exercise Tracker', Icons.fitness_center,
                ExerciseTrackerScreen(), [Colors.pink, Colors.red]),
            _buildMenuButton(context, 'Meal Planner', Icons.restaurant_menu,
                MealPlannerScreen(), [Colors.brown, Colors.orangeAccent]),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, IconData icon,
      Widget screen, List<Color> colors) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 10),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
