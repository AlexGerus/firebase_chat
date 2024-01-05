import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/pages/contact/view.dart';
import 'package:firebase_chat/pages/message/view.dart';
import 'package:firebase_chat/pages/profile/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handlePageChange,
      children: const [
        MessagePage(),
        ContactPage(),
        ProfilePage()
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTap,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          unselectedItemColor: AppColors.tabBarElement,
          selectedItemColor: AppColors.thirdElementText,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
