import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sium_notification/core/model/comments_model.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/model/user_model.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

import '../../core/model/notification_vote_model.dart';

class FirebaseUtilsImpl extends FirebaseUtils {
  @override
  Future<UserModel> registerUser(
      String? email, String? password, String? username) async {
    final firebase = FirebaseAuth.instance;

    try {
      final res = await firebase.createUserWithEmailAndPassword(
          email: email ?? "", password: password ?? "");
      if (res.user != null) {
        await res.user?.sendEmailVerification();
        await res.user?.updateDisplayName(username);
        return UserModel(
          email: res.user?.email,
          userName: res.user?.displayName,
        );
      } else {
        return const UserModel(errorDetail: "Error");
      }
    } catch (e) {
      print("Firebase ERROR: ${e.toString()}");
      return UserModel(errorDetail: e.toString());
    }
  }

  @override
  Future<UserCredential?> login(String? email, String? password) async {
    final firebase = FirebaseAuth.instance;
    try {
      final res = await firebase.signInWithEmailAndPassword(
          email: email ?? "", password: password ?? "");

      return res;
    } catch (e){
      return null;
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final firebase = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    final res = await googleSignIn.signIn();

    final auth = await res?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken, idToken: auth?.idToken);

    final firebaseAuth = await firebase.signInWithCredential(credential);

    return firebaseAuth;
  }

  @override
  Future<bool> checkLoggedIn() async {
    final firebase = FirebaseAuth.instance;

    final user = firebase.currentUser;

    return user != null;
  }

  @override
  Future<List<NotificationModel>> getNotificationList() async {
    final firebase = FirebaseFirestore.instance.collection("notifiche");
    List<NotificationModel> list = [];
    final collection = await firebase.get();
    for (var element in collection.docs) {
      debugPrint(element.data().toString());
      list.add(NotificationModel(
          title: element.get("title"),
          imageUrl: element.get("imageUrl"),
          sentBy: element.get("sentBy"),
          sentByUid: element.get("sentByUid"),
          date: dateUtils.parseStringToDateTime(element.get("date")),
          position: element.get("position"),
          floor: element.get("floor"),
          id: element.id,
          room: element.get("room"),
          comments: _getComments(element),
          votes: _getVotes(element),
          notificationImageUrl: _getNotificationImage(element),
          note: element.get("note")));
    }
    final oldList = list.where((element) => DateTime.now().difference(element.date!).inDays > 30).toList();
    oldList.forEach((e) async{
      list.removeWhere((element) => element.id == e.id);
      await collection.docs.firstWhere((element) => element.id == e.id).reference.delete();
    });
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    list.removeWhere((element) => element.sentByUid == userUid);
    return list;
  }

  @override
  Future<List<NotificationModel>> getOwnNotifiationList() async{
    final firebase = FirebaseFirestore.instance.collection("notifiche");
    List<NotificationModel> list = [];
    final collection = await firebase.get();
    for (var element in collection.docs) {
      debugPrint(element.data().toString());
      list.add(NotificationModel(
          title: element.get("title"),
          imageUrl: element.get("imageUrl"),
          sentBy: element.get("sentBy"),
          sentByUid: element.get("sentByUid"),
          date: dateUtils.parseStringToDateTime(element.get("date")),
          position: element.get("position"),
          floor: element.get("floor"),
          id: element.id,
          room: element.get("room"),
          notificationImageUrl: _getNotificationImage(element),
          comments: _getComments(element),
          votes: _getVotes(element),
          note: element.get("note")));
    }
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    list.removeWhere((element) => element.sentByUid != userUid);
    return list;
  }

  List<CommentsModel>? _getComments(QueryDocumentSnapshot<Map<String, dynamic>> element){
    if(element.data().containsKey("comments")){
      final commentsList = element.get("comments") as List?;
      return commentsList?.map((e) => CommentsModel(
        sentBy: e["sentBy"],
        sentByUid: e["sentByUid"],
        comment: e["comment"],
        imageUrl: e["imageUrl"]
      )).toList();
    }else{
      return [];
    }
  }

  List<NotificationVoteModel>? _getVotes(QueryDocumentSnapshot<Map<String, dynamic>> element){
    if(element.data().containsKey("votes")){
      final votesList = element.get("votes") as List?;
      return votesList?.map((e) => NotificationVoteModel(
        sentByUid: e["sentByUid"],
        vote: e["vote"]
      )).toList();
    }else{
      return [];
    }
  }

  String? _getNotificationImage(QueryDocumentSnapshot<Map<String, dynamic>> element){
    if(element.data().containsKey("notificationImageUrl")){
      return element.get("notificationImageUrl");
    }else{
      return "";
    }
  }

  @override
  Future<void> sendNotification(NotificationModel model) async {
    final firebase = FirebaseFirestore.instance.collection("notifiche");
    await firebase.add({
      "title": model.title ?? "",
      "sentBy": model.sentBy ?? "",
      "sentByUid": model.sentByUid ?? "",
      "date": dateUtils.getNowDateForFirebase(model.date) ?? "",
      "position": model.position ?? "",
      "floor": model.floor ?? "",
      "room": model.room ?? "",
      "note": model.note ?? "",
      "imageUrl": model.imageUrl ?? "",
      "notificationImageUrl": model.notificationImageUrl ?? ""
    });

    await FirebaseMessaging.instance.unsubscribeFromTopic("all");
    final _dio = Dio();
    _dio.interceptors.addAll([PrettyDioLogger(requestHeader: true)]);
    String body;
    body = (model.position ?? "") + " ";
    if(model.floor?.isNotEmpty == true){
      body = body + "Piano: ${model.floor} ";
    }if(model.room?.isNotEmpty == true){
      body = body + "Stanza: ${model.room} ";
    }
    body = body + "Inviato da ${model.sentBy}";
    final res = await _dio.request(
      "https://fcm.googleapis.com/fcm/send",
      options: Options(
        method: "POST",
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          "Authorization":
              "key=AAAAe5eKImc:APA91bH2qof93V77mv7OlBtRQPhpvS3KrUqYPnE6GcuW3xNz4hOnkeUNXKj1XpGSp2Gp8R32avEgoVpLrG8sP0WMWgDxFDvU1dab5R5AD-qbe1Yhv7Pk3r-XRYAyrYzePPgNIF1WafQe"
        },
      ),
      data: {
        "to": "/topics/all",
        "data": {
          "notificationId": model.id
        },
        "notification": {
          "title": model.title,
          "body": body
        }
      }
    );

    if(res.statusCode == 200){
      print("OK FCM");
    }else{
      print("ERROR");
    }
    await registerToAllTopic();
  }

  @override
  User? getCurrentUser() {
    final firebase = FirebaseAuth.instance;

    return firebase.currentUser;
  }

  @override
  Future<bool> editEmail(String? email) async {
    final firebase = FirebaseAuth.instance;

    if (email?.isNotEmpty == true && email != null) {
      try {
        await firebase.currentUser?.updateEmail(email);
        return firebase.currentUser?.email == email;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> editUsername(String? username) async {
    final firebase = FirebaseAuth.instance;

    if (username?.isNotEmpty == true && username != null) {
      try {
        await firebase.currentUser?.updateDisplayName(username);
        return firebase.currentUser?.displayName == username;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> editPassword(String? password) async {
    final firebase = FirebaseAuth.instance;

    if (password?.isNotEmpty == true && password != null) {
      try {
        await firebase.currentUser?.updatePassword(password);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    final firebase = FirebaseAuth.instance;

    await firebase.signOut();
  }

  @override
  Future<void> editProfileImage(File profileImage) async {
    final storage = FirebaseStorage.instance;
    final auth = FirebaseAuth.instance;

    final ref = storage
        .ref()
        .child("profilePicture")
        .child("${auth.currentUser?.email}/image");
    await ref.putFile(profileImage);

    final url = await ref.getDownloadURL();
    await auth.currentUser?.updatePhotoURL(url);
  }

  @override
  Future<String?> addImageToDb(XFile? file) async{
    final storage = FirebaseStorage.instance;

    try {
      final ref = storage
          .ref()
          .child("notificationPicture")
          .child("${file?.name}");
      final res = await ref.putFile(File(file?.path ?? ""));

      return await res.ref.getDownloadURL();
    }catch (e){
      return null;
    }
  }

  @override
  Future<bool> removeImageToDb(String? url) async{
    final storage = FirebaseStorage.instance;

    try {
      await storage.refFromURL(url ?? "").delete();
      return true;
    }catch (e){
      return false;
    }
  }

  @override
  Future<void> registerToAllTopic() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.subscribeToTopic("all");
  }

  @override
  Future<void> addNotificationComment(String? comment, NotificationModel? model, int? selectedVote) async{
    final firebase = FirebaseFirestore.instance.collection("notifiche");
    final user = FirebaseAuth.instance.currentUser;

    final collection = await firebase.get();
    final notification = collection.docs.firstWhere((element) => element.id == model?.id);
    final commentsElement = notification.data().containsKey("comments") ? notification.get("comments") as List? : [];
    if(comment?.isNotEmpty == true) {
      commentsElement?.add({
        "sentBy": user?.displayName ?? user?.email ?? "",
        "sentByUid": user?.uid ?? "",
        "comment": comment,
        "imageUrl": user?.photoURL ?? ""
      });
    }
    final voteElement = notification.data().containsKey("votes") ? notification.get("votes") as List? : [];
    if(voteElement?.any((element) => element?["sentByUid"] == user?.uid) == true){
      voteElement?.firstWhere((element) => element?["sentByUid"] == user?.uid)?["vote"] = selectedVote;
    }else{
      voteElement?.add({
        "sentByUid": user?.uid,
        "vote": selectedVote
      });
    }
    await notification.reference.update({
      "comments": commentsElement,
      "votes": voteElement
    });

    // Send notification to SIUM partecipant
    await FirebaseMessaging.instance.unsubscribeFromTopic("all");
    final _dio = Dio();
    _dio.interceptors.addAll([PrettyDioLogger(requestHeader: true)]);
    List<String> uidList = [];
    uidList.add(model?.sentByUid ?? "");
    model?.comments?.forEach((element) {
      uidList.add(element.sentByUid ?? "");
    });
    final res = await _dio.request(
        "https://fcm.googleapis.com/fcm/send",
        options: Options(
          method: "POST",
          headers: {
            Headers.contentTypeHeader: Headers.jsonContentType,
            "Authorization":
            "key=AAAAe5eKImc:APA91bH2qof93V77mv7OlBtRQPhpvS3KrUqYPnE6GcuW3xNz4hOnkeUNXKj1XpGSp2Gp8R32avEgoVpLrG8sP0WMWgDxFDvU1dab5R5AD-qbe1Yhv7Pk3r-XRYAyrYzePPgNIF1WafQe"
          },
        ),
        data: {
          "to": "/topics/all",
          "data":{
            "uid": uidList,
            "notificationId": model?.id
          }
        }
    );

    if(res.statusCode == 200){
      print("OK FCM");
    }else{
      print("ERROR");
    }
    await registerToAllTopic();
  }

  @override
  Future<void> deleteNotification(NotificationModel? model) async {
    final firebase = FirebaseFirestore.instance.collection("notifiche");

    final collection = await firebase.get();
    final notification = collection.docs.firstWhere((element) => element.id == model?.id);

    return await notification.reference.delete();
  }

  @override
  Future<bool> resetPassword(String? email) async{
    final firebase = FirebaseAuth.instance;
    try {
      await firebase.sendPasswordResetEmail(email: email ?? "");

      return true;
    }catch (e){
      return false;
    }

  }
}
