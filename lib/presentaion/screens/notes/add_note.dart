import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/widgets.dart';
import '../home.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection('notes');
  late String title;
  late String note;

  @override
  Widget build(BuildContext context) {
    addNote() async {
      showLoadingIndicator(context, 'Adding Note');
      await notesref.doc().set({
        'title': title,
        'note': note,
        'User Id': FirebaseAuth.instance.currentUser?.uid
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  title = value;
                },
                decoration: MytextFieldDecoration.copyWith(hintText: 'title'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  note = value;
                },
                decoration: MytextFieldDecoration.copyWith(hintText: 'note'),
              ),
              SizedBox(
                height: 24.0,
              ),
              MaterialButtonWidget(
                  color: Colors.deepOrangeAccent,
                  text: 'Add note',
                  function: () {
                    addNote();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
