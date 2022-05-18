import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/model/user_model.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class FirebaseUtilsImpl extends FirebaseUtils {
  @override
  Future<UserModel> registerUser(
      String? email, String? password, String? username) async {
    final firebase = FirebaseAuth.instance;

    try {
      final res = await firebase.createUserWithEmailAndPassword(
          email: email ?? "", password: password ?? "");
      if (res.user != null) {
        res.user?.sendEmailVerification();
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
  Future<UserCredential> login(String? email, String? password) async {
    final firebase = FirebaseAuth.instance;
    final res = await firebase.signInWithEmailAndPassword(
        email: email ?? "", password: password ?? "");

    return res;
  }

  @override
  Future<UserCredential> loginWithCredential(AuthCredential credential) async {
    final firebase = FirebaseAuth.instance;
    final res = await firebase.signInWithCredential(credential);

    return res;
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
      list.add(NotificationModel(
          title: element.get("title"),
          sentBy: element.get("sentBy"),
          sentByUid: element.get("sentByUid"),
          date: dateUtils.parseStringToDateTime(element.get("date")),
          position: element.get("position"),
          floor: element.get("floor"),
          id: element.id,
          room: element.get("room"),
          note: element.get("note")));
    }
    return list;
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
      "note": model.note ?? ""
    });

    //await FirebaseMessaging.instance.unsubscribeFromTopic("all");
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
    print(storage.toString());

    final ref = storage
        .ref()
        .child("profilePicture")
        .child("${auth.currentUser?.email}/image");
    await ref.putFile(profileImage);

    final url = await ref.getDownloadURL();
    await auth.currentUser?.updatePhotoURL(url);
  }

  @override
  Future<void> registerToAllTopic() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.subscribeToTopic("all");
  }
}
