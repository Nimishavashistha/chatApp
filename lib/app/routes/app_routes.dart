part of 'app_pages.dart';

abstract class AppRoutes {
  static const authScreen = _Paths.authScreen;
  static const chatScreen = _Paths.chatScreen;
  static const isSignedIn = _Paths.isSignedIn;
}

abstract class _Paths {
  static const authScreen = "/auth_screen";
  static const chatScreen = 'chat_screen';
  static const isSignedIn = '/is_signed_in';
}
