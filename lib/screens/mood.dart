import 'package:flutter/material.dart';
import 'package:noteapp/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class DailyMoodTrackerScreen extends StatefulWidget {
  @override
  _DailyMoodTrackerScreenState createState() => _DailyMoodTrackerScreenState();
}

class _DailyMoodTrackerScreenState extends State<DailyMoodTrackerScreen> {
  String selectedMood = 'Happy';
  List<String> moods = ['Happy', 'Sad', 'Excited', 'Angry', 'Neutral'];
  DateTime selectedDate = DateTime.now();
  Map<String, String> savedMoods = {};

  @override
  void initState() {
    super.initState();
    _loadMoods();
  }

  _loadMoods() async {
    savedMoods = await Provider.of<LocalStorageService>(context, listen: false)
        .loadMoods();
    setState(() {});
  }

  _saveMood() async {
    savedMoods[selectedDate.toIso8601String()] = selectedMood;
    await Provider.of<LocalStorageService>(context, listen: false)
        .saveMoods(savedMoods);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood saved for ${selectedDate.toLocal()}')),
    );
  }

  _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.teal,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  _removeMood(String date) async {
    savedMoods.remove(date);
    await Provider.of<LocalStorageService>(context, listen: false)
        .saveMoods(savedMoods);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood removed for $date')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Mood Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectDate,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Select Date: ${selectedDate.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedMood,
              onChanged: (newMood) {
                setState(() {
                  selectedMood = newMood!;
                });
              },
              items: moods.map<DropdownMenuItem<String>>((String mood) {
                return DropdownMenuItem<String>(
                  value: mood,
                  child: Text(mood),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMood,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Mood',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Saved Moods:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: savedMoods.length,
                itemBuilder: (context, index) {
                  String date = savedMoods.keys.toList()[index];
                  String mood = savedMoods[date]!;
                  return ListTile(
                    title: Text('Date: $date'),
                    subtitle: Text('Mood: $mood'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeMood(date),
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
