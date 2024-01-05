import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'index.dart';

class PhotoviewController extends GetxController {
  final state = PhotoviewState();

  PhotoviewController();

  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();

    var data = Get.parameters;
    if (data['url'] != null) {
      state.url.value = data['url']!;
    }
  }
}
