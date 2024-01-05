import 'dart:convert';

import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/routes.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'index.dart';

class ProfileController extends GetxController {
  ProfileController();

  final state = ProfileState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]);

  Future<void> onLogout() async {
    await UserStore.to.onLogout();
    await _googleSignIn.signOut();
    Get.offAndToNamed(AppRoutes.INITIAL);
  }

  asyncLoadAllData() async {
    String profile = await UserStore.to.getProfile();
    if (profile.isNotEmpty) {
      UserLoginResponseEntity user =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      state.headDetail.value = user;
    }
  }

  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();

    List myList = [
      { "name": "Account", "icon": "assets/icons/1.png", "route": "/account" },
      { "name": "Chat", "icon": "assets/icons/2.png", "route": "/chat" },
      { "name": "Notification", "icon": "assets/icons/3.png", "route": "/notification" },
      { "name": "Privacy", "icon": "assets/icons/4.png", "route": "/privacy" },
      { "name": "Help", "icon": "assets/icons/5.png", "route": "/help" },
      { "name": "About", "icon": "assets/icons/6.png", "route": "/about" },
      { "name": "Logout", "icon": "assets/icons/7.png", "route": "/logout" },
    ];

    for (int i = 0; i < myList.length; i++) {
      MeListItem result = MeListItem();
      result.name = myList[i]["name"];
      result.icon = myList[i]["icon"];
      result.route = myList[i]["route"];
      state.meListItem.add(result);
    }
  }
}
