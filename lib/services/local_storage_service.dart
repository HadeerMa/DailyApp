import 'dart:convert';
import 'package:noteapp/models/notemodel.dart';
import 'package:noteapp/models/taskModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => json.encode(task.toJson())).toList();
    await prefs.setStringList('tasks', taskList);
  }

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks') ?? [];
    return taskList
        .map((task) => TaskModel.fromJson(json.decode(task)))
        .toList();
  }

  Future<void> saveNotes(List<NoteModel> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final noteList = notes.map((note) => json.encode(note.toJson())).toList();
    await prefs.setStringList('notes', noteList);
  }

  Future<List<NoteModel>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final noteList = prefs.getStringList('notes') ?? [];
    return noteList
        .map((note) => NoteModel.fromJson(json.decode(note)))
        .toList();
  }

  Future<void> saveHabits(List<String> habits) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('habits', habits);
  }

  Future<List<String>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('habits') ?? [];
  }

  Future<void> saveCompletedHabits(Set<String> completedHabits) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('completed_habits', completedHabits.toList());
  }

  Future<Set<String>> loadCompletedHabits() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedHabits = prefs.getStringList('completed_habits');
    return Set.from(savedHabits ?? []);
  }

  Future<void> saveMoods(Map<String, String> moods) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> moodList = moods.entries.map((entry) {
      return json.encode({'date': entry.key, 'mood': entry.value});
    }).toList();
    await prefs.setStringList('moods', moodList);
  }

  Future<Map<String, String>> loadMoods() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> moodData = {};
    final moodList = prefs.getStringList('moods') ?? [];
    for (var moodEntry in moodList) {
      Map<String, dynamic> decodedMood = json.decode(moodEntry);
      moodData[decodedMood['date']] = decodedMood['mood'];
    }
    return moodData;
  }

   Future<void> saveExercises(List<Map<String, String>> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    final exerciseList = exercises.map((exercise) => json.encode(exercise)).toList();
    await prefs.setStringList('exercises', exerciseList);
  }

  Future<List<Map<String, String>>> loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final exerciseList = prefs.getStringList('exercises') ?? [];
    return exerciseList.map((exercise) => Map<String, String>.from(json.decode(exercise))).toList();
  }
}
