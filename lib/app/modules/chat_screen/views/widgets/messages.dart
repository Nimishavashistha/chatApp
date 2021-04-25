import 'package:chat_app/app/modules/chat_screen/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<ChatController>().getUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatDocs = chatSnapshot.data.docs;
                return ListView.builder(
                    reverse: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                          message: chatDocs[index]['text'],
                          userName: chatDocs[index]['username'],
                          isMe: chatDocs[index]['userId'] ==
                              futureSnapshot.data.uid,
//                              key: ValueKey(chatDocs[index]),
                        ));
              });
        });
  }
}
