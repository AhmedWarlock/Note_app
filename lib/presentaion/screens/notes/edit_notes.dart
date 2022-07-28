import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/cubit/app_cubit.dart';

import '../../widgets/widgets.dart';
import '../home.dart';

class EditNotes extends StatefulWidget {
  EditNotes({Key? key, required this.note, required this.docId})
      : super(key: key);
  final note;
  final docId;

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late String title;
  late String note;
  @override
  void initState() {
    title = widget.note['title'];
    note = widget.note['note'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    editNote() async {
      showLoadingIndicator(context, 'Adding Note');
      BlocProvider.of<AppCubit>(context).editANote(
          title: title,
          note: note,
          docID: widget.docId,
          uId:
              BlocProvider.of<AppCubit>(context).firebaseAuth.currentUser!.uid);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: widget.note['title'],
                  onChanged: (value) {
                    title = value;
                  },
                  decoration:
                      MytextFieldDecoration.copyWith(hintText: 'Note title'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: widget.note['note'],
                  onChanged: (value) {
                    note = value;
                  },
                  decoration: MytextFieldDecoration.copyWith(hintText: ''),
                ),
                SizedBox(
                  height: 24.0,
                ),
                MaterialButtonWidget(
                    color: Colors.deepOrangeAccent,
                    text: 'Save',
                    function: () {
                      editNote();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
