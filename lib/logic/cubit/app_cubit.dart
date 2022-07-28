import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/data/note_repository.dart';

import '../../presentaion/widgets/widgets.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final NoteRepository repository;
  StreamSubscription? authStream;
  final FirebaseAuth firebaseAuth;
  AppCubit({required this.repository, required this.firebaseAuth})
      : super(AppInitial()) {
    authStream = firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        emitSignedoutState();
      } else {
        emitSignedInState();
      }
    });
  }

  void emitLoadingState() => emit(LoadingState());
  void emitSignedInState() => emit(SignedInState());
  void emitSignedoutState() => emit(SignedOutState());

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    emitSignedoutState();
  }

  Future emailSignIn(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    try {
      showLoadingIndicator(context, 'Signing in..');
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      emitSignedInState();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();

        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text('User note found'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              );
            });
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();

        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text('Wrong Password'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: const TextStyle(fontSize: 18),
                      )),
                ],
              );
            });
      }
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future emailSignUp(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    try {
      showLoadingIndicator(context, 'Creating account');
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      emitSignedInState();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();

        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text('Password too weak'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              );
            });
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();

        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text('Email already in use'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              );
            });
      }
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future<void> addANote(
          {required String title,
          required String note,
          required String uId}) async =>
      repository.addANote(title: title, note: note, uId: uId);

  Future<void> editANote(
          {required String title,
          required String note,
          required docID,
          required String uId}) async =>
      repository.editANote(title: title, note: note, docID: docID, userId: uId);

  Future<void> deleteNote(String docId) async => repository.deleteNote(docId);
}
