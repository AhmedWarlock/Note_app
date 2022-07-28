import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/cubit/app_cubit.dart';

import '../widgets/widgets.dart';
import 'home.dart';
import 'sign_up.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    Future signin() async {
      BlocProvider.of<AppCubit>(context)
          .emailSignIn(email: email, pass: password, context: context);
      Navigator.pushReplacementNamed(context, 'home');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: MytextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: MytextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                MaterialButtonWidget(
                    color: Colors.deepOrangeAccent,
                    text: 'Log In',
                    function: () {
                      signin();
                    }),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Not Signed up yet ?'),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'signup');
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
