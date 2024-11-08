import 'package:flutter/material.dart';
import 'package:noteapp/models/taskModel.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel task;
  final Function(TaskModel) onSave;

  TaskDetailsScreen({required this.task, required this.onSave});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
  }

  void _saveTask() {
    widget.task.title = _titleController.text;
    widget.onSave(widget.task);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task saved successfully!"),
        backgroundColor: Colors.teal,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                labelStyle: TextStyle(color: Colors.teal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                fillColor: Colors.teal.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.task, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveTask,
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
