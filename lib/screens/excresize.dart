import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/local_storage_service.dart';

class ExerciseTrackerScreen extends StatefulWidget {
  @override
  _ExerciseTrackerScreenState createState() => _ExerciseTrackerScreenState();
}

class _ExerciseTrackerScreenState extends State<ExerciseTrackerScreen> {
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  List<Map<String, String>> exercises = [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  void _loadExercises() async {
    exercises = await Provider.of<LocalStorageService>(context, listen: false)
        .loadExercises();
    setState(() {});
  }

  void _addExercise() {
    if (_exerciseNameController.text.isNotEmpty &&
        _durationController.text.isNotEmpty &&
        _caloriesController.text.isNotEmpty) {
      setState(() {
        exercises.add({
          'name': _exerciseNameController.text,
          'duration': _durationController.text,
          'calories': _caloriesController.text,
        });
      });

      Provider.of<LocalStorageService>(context, listen: false)
          .saveExercises(exercises);

      _exerciseNameController.clear();
      _durationController.clear();
      _caloriesController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exercise added!')),
      );
    }
  }

  // Delete exercise and update SharedPreferences
  void _deleteExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });

    // Save updated exercises list to SharedPreferences
    Provider.of<LocalStorageService>(context, listen: false)
        .saveExercises(exercises);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exercise removed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Add Your Exercise',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _exerciseNameController,
              decoration: InputDecoration(
                labelText: 'Exercise Name',
                labelStyle: TextStyle(color: Colors.teal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                fillColor: Colors.teal.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duration (in minutes)',
                labelStyle: TextStyle(color: Colors.teal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                fillColor: Colors.teal.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(
                labelText: 'Calories Burned',
                labelStyle: TextStyle(color: Colors.teal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                fillColor: Colors.teal.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addExercise,
              child: Text(
                'Add Exercise',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Today\'s Exercises',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.fitness_center, color: Colors.teal),
                    title: Text(exercises[index]['name'] ?? ''),
                    subtitle: Text(
                        'Duration: ${exercises[index]['duration']} mins, Calories: ${exercises[index]['calories']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteExercise(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
