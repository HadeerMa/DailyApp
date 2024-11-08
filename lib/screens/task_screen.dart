import 'package:flutter/material.dart';
import 'package:noteapp/models/taskModel.dart';
import 'package:noteapp/screens/TaskDetailsScreen.dart';
import '../services/local_storage_service.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();
  List<TaskModel> tasks = [];
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    tasks = await _localStorageService.loadTasks();
    setState(() {});
  }

  void _addTask() {
    if (_titleController.text.isEmpty || _selectedDueDate == null) return;

    final task = TaskModel(
      id: DateTime.now().toString(),
      title: _titleController.text,
      dueDate: _selectedDueDate!,
      isCompleted: false,
    );

    setState(() {
      tasks.add(task);
    });

    _localStorageService.saveTasks(tasks);
    _titleController.clear();
    _selectedDueDate = null;
  }

  void _showAddTaskDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',

                  labelStyle: TextStyle(color: Colors.teal),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  fillColor:
                      Colors.teal.withOpacity(0.1), 
                  filled: true, 
                ),
                cursorColor: Colors.teal,
                style: TextStyle(color: Colors.teal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    _selectedDueDate == null
                        ? 'Select Due Date'
                        : '${_selectedDueDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _pickDueDate,
                    child: Text("Pick Date",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _addTask();
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  "Add Task",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal, 
              onPrimary: Colors.white,
              surface: Colors.teal,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _editTask(TaskModel task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(
          task: task,
          onSave: (updatedTask) {
            setState(() {});
            _localStorageService.saveTasks(tasks);
          },
        ),
      ),
    );
  }

  void _toggleTaskCompletion(TaskModel task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    _localStorageService.saveTasks(tasks);
  }

  void _deleteTask(TaskModel task) {
    setState(() {
      tasks.remove(task);
    });
    _localStorageService.saveTasks(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black,
                ),
              ),
              subtitle: Text('${task.dueDate.toLocal()}'.split(' ')[0]),
              onTap: () => _editTask(task),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      task.isCompleted
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.teal,
                    ),
                    onPressed: () => _toggleTaskCompletion(task),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(task),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
