// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// note_model.dart
class Note {
  String title;
  String content;

  Note({required this.title, required this.content});
}

// notes_page.dart

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [];

  void _showNoteDialog({Note? note}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    if (note != null) {
      titleController.text = note.title;
      contentController.text = note.content;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null ? 'Add Note' : 'Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (note == null) {
                    _notes.add(Note(
                      title: titleController.text,
                      content: contentController.text,
                    ));
                  } else {
                    note.title = titleController.text;
                    note.content = contentController.text;
                  }
                });
                Navigator.pop(context);
              },
              child: Text(note == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Page'),
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notes[index].title),
            subtitle: Text(_notes[index].content),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteNote(index);
              },
            ),
            onTap: () {
              _showNoteDialog(note: _notes[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
