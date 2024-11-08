import 'package:flutter/material.dart';
import 'package:noteapp/models/notemodel.dart';
import 'package:provider/provider.dart';
import '../services/local_storage_service.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    notes = await Provider.of<LocalStorageService>(context, listen: false)
        .loadNotes();
    setState(() {});
  }

  void _addNote(String title) {
    final note = NoteModel(
        id: DateTime.now().toString(), content: title, date: DateTime.now());
    setState(() => notes.add(note));
    Provider.of<LocalStorageService>(context, listen: false).saveNotes(notes);
  }

  void _deleteNote(NoteModel note) {
    setState(() => notes.remove(note));
    Provider.of<LocalStorageService>(context, listen: false).saveNotes(notes);
  }

  void _showAddNoteDialog() {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Note',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Note Title',
            labelStyle: TextStyle(color: Colors.teal),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            filled: true,
            fillColor: Colors.teal.withOpacity(0.1),
          ),
          style: TextStyle(color: Colors.teal),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.teal)),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                _addNote(titleController.text);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Add Note',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Positive Notes',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(note.content, style: TextStyle(color: Colors.teal)),
                subtitle:
                    Text('Added on: ${note.date.toString().split(' ')[0]}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteNote(note),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
