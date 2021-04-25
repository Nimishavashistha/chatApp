import 'package:chat_app/app/modules/chat_screen/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        builder: (controller) => Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller.controller,
                    decoration:
                        InputDecoration(labelText: 'Send a message....'),
                    onChanged: (val) {
                      controller.changeEnteredMessage(val);
                    },
                  )),
                  IconButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: controller.enteredMessage.trim().isEmpty
                          ? null
                          : controller.sendMessage,
                      icon: Icon(Icons.send))
                ],
              ),
            ));
  }
}
