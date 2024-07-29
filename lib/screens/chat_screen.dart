import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = 'chat screen';
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController=ScrollController();
  CollectionReference message = FirebaseFirestore.instance.collection(kCollectionID);

  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('createdAt',descending: true).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            List<MessageModel>messagesList=[];
            for(int i=0;i<snapshot.data!.docs.length;i++){
              messagesList.add(MessageModel.fromJason(snapshot.data!.docs[i]));
            }            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 60,
                    ),
                    Text(
                      'chat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return messagesList[index].email==email? customBubble(
                          bottomLeft: 0,
                          bottomRight: 36,
                          messageModel: messagesList[index],
                        ):customBubbleForFriend(bottomLeft: 36, bottomRight: 0, messageModel:messagesList[index]);
                      },
                      itemCount: messagesList.length,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: InkWell(
                              onTap: () {
                                message.add({'message': controller.text,
                                'createdAt':DateTime.now(),
                                  'email':email
                                });
                                controller.clear();
                                _scrollController.animateTo(
                                 0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: Icon(
                                Icons.send,
                                color: kPrimaryColor,
                                size: 32,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: kPrimaryColor))),
                    ),
                  )
                ],
              ),
            );

          }
          else {
            return const Scaffold(body: Center(child: Text('loading')));
          }


        });
  }
}
