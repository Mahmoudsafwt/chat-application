import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class customBubble extends StatelessWidget {
   customBubble({ required this.bottomLeft, required this.bottomRight,required this.messageModel});
  double bottomRight;
  double bottomLeft;
 final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 32,bottom: 32),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        width: 200,
        height: 80,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(bottomRight),
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35), bottomLeft: Radius.circular(bottomLeft)),


        ),
        child: Text(
          messageModel.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class customBubbleForFriend extends StatelessWidget {
  customBubbleForFriend({ required this.bottomLeft, required this.bottomRight,required this.messageModel});
double bottomRight;
double bottomLeft;
final MessageModel messageModel;

@override
Widget build(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 32,bottom: 32),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      width: 200,
      height: 80,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(bottomRight),
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35), bottomLeft: Radius.circular(bottomLeft)),


      ),
      child: Text(
        messageModel.message,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
}
