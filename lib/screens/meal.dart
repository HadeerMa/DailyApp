import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<String> meals = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  Map<String, String> mealPlans = {};
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _loadMealPlans();
  }

  Future<void> _loadMealPlans() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      mealPlans = Map<String, String>.from(
        (prefs?.getString('mealPlans') != null)
            ? json.decode(prefs!.getString('mealPlans')!)
            : {},
      );
    });
  }

  Future<void> _saveMealPlans() async {
    if (prefs != null) {
      await prefs!.setString('mealPlans', json.encode(mealPlans));
    }
  }

  void _addMeal(BuildContext context, String mealType) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add $mealType'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter your meal',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            fillColor: Colors.teal.withOpacity(0.1),
            filled: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                mealPlans[mealType] = controller.text;
              });
              _saveMealPlans();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeeklyPlan() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Weekly Meal Plan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: meals.map((mealType) {
            return Text(
              '$mealType: ${mealPlans[mealType] ?? 'No meal added'}',
              style: TextStyle(fontSize: 16),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            String mealType = meals[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  mealType,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                subtitle: Text(
                  mealPlans[mealType] ?? 'No meal added',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.teal),
                  onPressed: () {
                    _addMeal(context, mealType);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showWeeklyPlan,
        child: const Icon(
          Icons.calendar_today,
          color: Colors.white,
        ),
        tooltip: 'View Weekly Plan',
      ),
    );
  }
}
