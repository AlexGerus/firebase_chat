import 'package:get/get.dart';

import 'index.dart';

class PhotoviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoviewController>(() => PhotoviewController());
  }
}
