import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class SignUp extends StatefulWidget {
  static const String routeName = 'sign in screen';

  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'scholarChat',
                    style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField('Email', (data) {
                    email = data;
                  }, (data) {
                    if (data == null || data.length < 5)
                      return 'please enter your email';
                  }),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomTextField('password', (data) {
                    password = data;
                  }, (password) {
                    if (password == null || password.length < 9) {
                      return 'password must be contain 9 chars at least';
                    }
                  },true),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomButton('Sign up', () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        inAsyncCall = true;
                      });
                      try {
                        await userRegistration();
                        showSnackBar(context, 'successfully go to login screen');
                        Navigator.pushNamed(context, LogIn.routeName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email-already-in-use');
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                        showSnackBar(context, 'check your internet connection');

                      }
                      setState(() {
                        inAsyncCall = false;
                      });
                    }
                  }),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'you alredy have an account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LogIn.routeName);
                        },
                        child: Text('Sign in',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<void> userRegistration() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
