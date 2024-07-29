import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
 runApp(ChatApp());

}
class ChatApp extends StatelessWidget{



 Widget build(BuildContext){

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     initialRoute: SignUp.routeName,
     routes: {
       SignUp.routeName:(context)=>SignUp(),
       LogIn.routeName:(context)=>LogIn(),
       ChatScreen.routeName:(context)=>ChatScreen(),
     },

   );
 }


}

