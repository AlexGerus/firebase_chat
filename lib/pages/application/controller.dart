import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/common/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'index.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();

  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  void handlePageChange(int index) {
    state.page = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ["Chat", "Contact", "Profile"];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_text_fill,
              color: AppColors.thirdElementText),
          activeIcon: Icon(CupertinoIcons.chat_bubble_text_fill,
              color: AppColors.secondaryElementText),
          label: "Chat",
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_alt_circle_fill,
              color: AppColors.thirdElementText),
          activeIcon: Icon(CupertinoIcons.person_alt_circle_fill,
              color: AppColors.secondaryElementText),
          label: "Contact",
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_fill,
              color: AppColors.thirdElementText),
          activeIcon: Icon(CupertinoIcons.person_fill,
              color: AppColors.secondaryElementText),
          label: "Profile",
          backgroundColor: AppColors.primaryBackground)
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
