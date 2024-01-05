import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/common/values/shadows.dart';
import 'package:firebase_chat/common/widgets/app.dart';
import 'package:firebase_chat/common/widgets/button.dart';
import 'package:firebase_chat/common/widgets/image.dart';
import 'package:firebase_chat/pages/message/chat/widgets/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'index.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  AppBar _buildAppBar() {
    return transparentAppBar(
        title: Container(
      padding: EdgeInsets.only(top: 0.w, right: 0.w, bottom: 0.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 0.w, right: 0.w, bottom: 0.w),
            child: InkWell(
                child: SizedBox(
              width: 44.w,
              height: 44.w,
              child: netImageCached(controller.state.to_avatar.value),
            )),
          ),
          SizedBox(
            width: 15.w,
          ),
          Container(
            width: 180.w,
            padding: EdgeInsets.only(top: 0.w, right: 0.w, bottom: 0.w),
            child: Row(
              children: [
                SizedBox(
                    width: 180.w,
                    height: 44.w,
                    child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.state.to_name.value,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.primaryBackground),
                            ),
                            Obx(() => Text(
                                  controller.state.to_location.value,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                      color: AppColors.primaryBackground),
                                ))
                          ],
                        )))
              ],
            ),
          )
        ],
      ),
    ));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading:
                    const Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
                title: const Text("Gallery"),
                onTap: () {
                  controller.imgFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  controller.imgFromCamera();
                  Get.back();
                },
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              children: [
                const ChatList(),
                Positioned(
                    bottom: 0.h,
                    height: 50.h,
                    child: Container(
                      width: 360.w,
                      height: 50.h,
                      color: AppColors.primaryBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 217.w,
                            height: 50.h,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              controller: controller.textController,
                              autofocus: false,
                              focusNode: controller.contentNode,
                              decoration: const InputDecoration(
                                  hintText: "Send messages..."),
                            ),
                          ),
                          Container(
                              width: 30.w,
                              height: 30.h,
                              margin: EdgeInsets.only(left: 5.w),
                              child: GestureDetector(
                                child: Icon(CupertinoIcons.photo,
                                    size: 35.w, color: Colors.blue),
                                onTap: () => _showPicker(context),
                              )),
                          Container(
                              width: 65.w,
                              height: 35.w,
                              margin: EdgeInsets.only(left: 10.w, top: 5.h),
                              child: btnFlatButtonWidget(
                                title: "Send",
                                onPressed: () => controller.sendMessage(),
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
