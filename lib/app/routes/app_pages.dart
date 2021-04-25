import 'package:chat_app/app/modules/auth_screen/binding/auth_binding.dart';
import 'package:chat_app/app/modules/auth_screen/views/auth_screen.dart';
import 'package:chat_app/app/modules/chat_screen/binding/chat_binding.dart';
import 'package:chat_app/app/modules/chat_screen/views/chat_screen.dart';
import 'package:chat_app/app/modules/utils/is_signed_in.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var transitionDuration = const Duration(milliseconds: 300);
  static final pages = <GetPage>[
    GetPage(
        name: _Paths.authScreen,
        page: () => AuthScreen(),
        transitionDuration: transitionDuration,
        binding: AuthBinding()),
    GetPage(
        name: _Paths.chatScreen,
        page: () => ChatScreen(),
        binding: ChatBinding(),
        transitionDuration: transitionDuration),
    GetPage(
        name: _Paths.isSignedIn,
        page: () => isSignedIn(),
        binding: AuthBinding(),
        transitionDuration: transitionDuration)
  ];
}
