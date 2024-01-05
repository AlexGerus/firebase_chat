import 'package:firebase_chat/common/middlewares/middlewares.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/pages/application/index.dart';
import 'package:firebase_chat/pages/message/chat/index.dart';
import 'package:firebase_chat/pages/contact/index.dart';
import 'package:firebase_chat/pages/message/index.dart';
import 'package:firebase_chat/pages/message/photoview/index.dart';
import 'package:firebase_chat/pages/profile/index.dart';
import 'package:firebase_chat/pages/sign-in/index.dart';
import 'package:firebase_chat/pages/welcome/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPLICATION = AppRoutes.APPLICATION;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.INITIAL,
        page: () => const WelcomePage(),
        binding: WelcomeBinding(),
        middlewares: [RouteWelcomeMiddleware(priority: 1)]),
    GetPage(
        name: AppRoutes.SIGN_IN,
        page: () => const SignInPage(),
        binding: SignInBinding()),
    GetPage(
        name: AppRoutes.APPLICATION,
        page: () => const ApplicationPage(),
        binding: ApplicationBinding()),
    GetPage(
        name: AppRoutes.MESSAGE,
        page: () => const MessagePage(),
        binding: MessageBinding()),
    GetPage(
        name: AppRoutes.CONTACT,
        page: () => const ContactPage(),
        binding: ContactBinding()),
    GetPage(
        name: AppRoutes.CHAT,
        page: () => const ChatPage(),
        binding: ChatBinding()),
    GetPage(
        name: AppRoutes.ME,
        page: () => const ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: AppRoutes.PHOTO_IMG_VIEW,
        page: () => const PhotoviewPage(),
        binding: PhotoviewBinding())
  ];
}
