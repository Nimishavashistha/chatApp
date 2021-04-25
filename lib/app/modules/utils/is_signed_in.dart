import 'package:chat_app/app/modules/auth_screen/controller/auth_controller.dart';
import 'package:chat_app/app/modules/auth_screen/views/auth_screen.dart';
import 'package:chat_app/app/modules/chat_screen/controller/chat_controller.dart';
import 'package:chat_app/app/modules/chat_screen/views/chat_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class isSignedIn extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return GetBuilder<AuthController>(builder: (controller) {
      if (controller.user != null) {
        return ChatScreen();
      } else {
        return AuthScreen();
      }
    });
  }
}
