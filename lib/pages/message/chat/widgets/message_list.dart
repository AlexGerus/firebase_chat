import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/utils/date.dart';
import 'package:firebase_chat/common/values/values.dart';
import 'package:firebase_chat/common/widgets/image.dart';
import 'package:firebase_chat/pages/message/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({Key? key}) : super(key: key);

  Widget MessageListItem(QueryDocumentSnapshot<Msg> item) {
    return Container(
        padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
        child: InkWell(
            onTap: () {
              controller.goChat(item);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
                    child: SizedBox(
                      width: 54.w,
                      height: 54.w,
                      child: netImageCached(
                          item.data().from_uid == controller.token
                              ? item.data().to_avatar ?? ""
                              : item.data().from_avatar ?? ""),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 5.w),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xffe5efe5)))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250.w,
                        height: 48.w,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.data().from_uid == controller.token
                                      ? item.data().to_name ?? ""
                                      : item.data().from_name ?? "",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: AppColors.thirdElement),
                                ),
                                Text(
                                  item.data().last_msg ?? "",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp,
                                      color: AppColors.thirdElement),
                                )
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    duTimeLineFormat(
                                        (item.data().last_time as Timestamp)
                                            .toDate()),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp,
                                        color: AppColors.thirdElement),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: controller.refreshController,
        onLoading: controller.onLoading,
        onRefresh: controller.onRefresh,
        header: const WaterDropHeader(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var item = controller.state.msgList[index];
                  return MessageListItem(item);
                }, childCount: controller.state.msgList.length),
              ),
            )
          ],
        )));
  }
}
