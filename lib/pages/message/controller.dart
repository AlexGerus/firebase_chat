import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/routes.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/common/utils/http.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'index.dart';

class MessageController extends GetxController {
  final state = MessageState();

  MessageController();

  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  void goChat(QueryDocumentSnapshot<Msg> item) {
    var to_uid = item.data().from_uid == token
        ? item.data().to_uid
        : item.data().from_uid;
    var to_name = item.data().from_uid == token
        ? item.data().to_name
        : item.data().from_name;
    var to_avatar = item.data().from_uid == token
        ? item.data().to_avatar
        : item.data().from_avatar;

    Get.toNamed(AppRoutes.CHAT, parameters: {
      "doc_id": item.id,
      "to_uid": to_uid ?? "",
      "to_name": to_name ?? "",
      "to_avatar": to_avatar ?? "",
    });
  }

  void onRefresh() {
    asyncLoadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    asyncLoadAllData().then((_) {
      refreshController.loadComplete();
    }).catchError((_) {
      refreshController.loadFailed();
    });
  }

  asyncLoadAllData() async {
    var from_messages = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .get();

    var to_messages = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_uid", isEqualTo: token)
        .get();

    state.msgList.clear();
    if (from_messages.docs.isNotEmpty) {
      state.msgList.assignAll(from_messages.docs);
    }

    if (to_messages.docs.isNotEmpty) {
      state.msgList.assignAll(to_messages.docs);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getUserLocation();
    getFcmToken();
  }

  getUserLocation() async {
    try {
      final location = await Location().getLocation();
      String address = "${location.latitude} ${location.longitude}";
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyBjmUX-0ozGBjN8vCt2v8rUv1c9ELXGc9Y";
      var response = await HttpUtil().get(url);
      MyLocation location_res = MyLocation.fromJson(response);
      if (location_res.status == "OK") {
        String? myAddress = location_res.results?.first.formattedAddress;
        print("Address $myAddress");
        if (myAddress != null) {
          var userLocation =
              await db.collection("users").where("id", isEqualTo: token).get();
          if (userLocation.docs.isNotEmpty) {
            var docId = userLocation.docs.first.id;
            await db
                .collection("users")
                .doc(docId)
                .update({"location": myAddress});
          }
        }
      }
    } catch (e) {
      print("Getting error: $e");
    }
  }

  getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      var user =
          await db.collection("users").where("id", isEqualTo: token).get();
      if (user.docs.isNotEmpty) {
        var doc_id = user.docs.first.id;
        await db.collection("users").doc(doc_id).update({"fcmtoken": fcmToken});
      }
    }
  }
}
