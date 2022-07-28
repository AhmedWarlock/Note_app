import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepository {
  final CollectionReference firestore;

  NoteRepository({required this.firestore});

  Future<void> addANote(
      {required String title,
      required String note,
      required String uId}) async {
    await firestore.doc().set({'title': title, 'note': note, 'User Id': uId});
  }

  Future<void> editANote(
      {required String title,
      required String note,
      required docID,
      required String userId}) async {
    await firestore
        .doc(docID)
        .update({'title': title, 'note': note, 'User Id': userId});
  }

  Future<void> deleteNote(String docId) async {
    await firestore.doc(docId).delete();
  }
}
