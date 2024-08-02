import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class LogIn extends StatefulWidget {
  static const String routeName = 'login screen';
  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                  const Text(
                    'scholarChat',
                    style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'LogIn',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField('Email', (data) {
                    email = data;
                  }, (data) {
                    if (data == null || data.length < 5) {
                      return 'please enter your email';
                    }
                  }),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomTextField('password', (data) {
                    password = data;
                  }, (data) {
                    if (data == null || data.length < 9) {
                      return 'password must be contain 9 chars at least';
                    }
                  },true),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomButton('LOGIN', () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        inAsyncCall = true;
                      });
                      try {
                        await userLogin(context);
                        Navigator.pushNamed(context, ChatScreen.routeName,arguments: email);
                      } catch (e) {
                         showSnackBar(context,e.toString());


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
                      const Text(
                        'dont have an account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('registar',
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



  Future<void> userLogin(BuildContext context) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);

  }
}
