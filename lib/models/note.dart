import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/logic/cubit/app_cubit.dart';

import '../presentaion/screens/home.dart';
import '../presentaion/screens/notes/edit_notes.dart';
import '../presentaion/screens/notes/view_notes.dart';

class Notes extends StatelessWidget {
  final note;
  final docID;
  Notes({this.note, this.docID});

  @override
  Widget build(BuildContext context) {
    showConfirmDialog(context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete'),
              content: Text('Are You Sure You Want To Delete This Note ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      BlocProvider.of<AppCubit>(context).deleteNote(docID);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    },
                    child: Text('Delete',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
              ],
            );
          });
    }

    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Viewnote(
              note: note,
              docId: docID,
            );
          }));
        },
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: (context) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return EditNotes(docId: docID, note: note);
                          }));
                        },
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) {
                          showConfirmDialog(context);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text('${note['title']}'),
                    subtitle: Text(
                      '${note['note']}',
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
