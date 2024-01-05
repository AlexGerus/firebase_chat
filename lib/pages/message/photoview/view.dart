import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/common/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'index.dart';

class PhotoviewPage extends GetView<PhotoviewController> {
  const PhotoviewPage({Key? key}) : super(key: key);

  AppBar _buildAppBar() {
    return transparentAppBar(
      title: Text(
          "Photoview",
          style: TextStyle(
              color: AppColors.primaryBackground,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: PhotoView(
            imageProvider: NetworkImage(controller.state.url.value)
        ),
      ),
    );
  }
}
