import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitTrackerScreen extends StatefulWidget {
  @override
  _HabitTrackerScreenState createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  List<String> habits = [
    'Drink Water',
    'Exercise',
    'Read Books',
    'Meditate',
    'Sleep Early',
    'Eat Healthy',
    'Practice Gratitude',
    'Learn Something New',
    'Walk 10,000 Steps',
    'Write a Journal'
  ];
  Set<String> completedHabits = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedHabits();
  }

  _loadCompletedHabits() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedHabits = prefs.getStringList('completed_habits');
    if (savedHabits != null) {
      setState(() {
        completedHabits = Set.from(savedHabits);
      });
    }
  }

  _saveCompletedHabits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('completed_habits', completedHabits.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          String habit = habits[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 5,
            child: ListTile(
              title: Text(habit),
              trailing: IconButton(
                icon: Icon(
                  completedHabits.contains(habit)
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: completedHabits.contains(habit)
                      ? Colors.green
                      : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (completedHabits.contains(habit)) {
                      completedHabits.remove(habit);
                    } else {
                      completedHabits.add(habit);
                    }
                    _saveCompletedHabits();
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
