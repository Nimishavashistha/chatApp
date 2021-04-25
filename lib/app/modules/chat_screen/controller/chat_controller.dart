import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var enteredMessage = "";
  final controller = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getUser() async {
    return _auth.currentUser;
  }

  void changeEnteredMessage(value) {
    enteredMessage = value;
    update();
  }

  void sendMessage() async {
    FocusScope.of(Get.context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    print("username = ${userData['username']}");
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username']
    });
    controller.clear();
  }
}
