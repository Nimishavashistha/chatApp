import 'package:chat_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

abstract class RoutesManagement {
  static void goToChatScreen() {
    Get.toNamed(AppRoutes.chatScreen);
  }
}
