import 'package:flutter/material.dart';
import 'package:note_app/presentaion/screens/notes/edit_notes.dart';

class Viewnote extends StatelessWidget {
  Viewnote({Key? key, required this.note, required this.docId})
      : super(key: key);
  final note;
  final docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditNotes(
              docId: docId,
              note: note,
            );
          }));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(note['title']),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          note['note'],
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
