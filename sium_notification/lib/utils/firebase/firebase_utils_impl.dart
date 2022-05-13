import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sium_notification/core/model/notification_model.dart';
import 'package:sium_notification/core/model/user_model.dart';
import 'package:sium_notification/utils/di_service.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class FirebaseUtilsImpl extends FirebaseUtils{
  @override
  Future<UserModel> registerUser(String? email, String? password, String? username) async{
    final firebase = FirebaseAuth.instance;

    try {
      final res = await firebase.createUserWithEmailAndPassword(
          email: email ?? "", password: password ?? "");
      if(res.user != null){
        await res.user?.updateDisplayName(username);
        return UserModel(email: res.user?.email, userName: res.user?.displayName,);
      }else{
        return const UserModel(errorDetail: "Error");
      }
    } catch (e){
      print("Firebase ERROR: ${e.toString()}");
      return UserModel(errorDetail: e.toString());
    }
  }

  @override
  Future<UserCredential> login(String? email, String? password) async{
    final firebase = FirebaseAuth.instance;
    final res = await firebase.signInWithEmailAndPassword(email: email ?? "", password: password ?? "");

    return res;
  }

  @override
  Future<UserCredential> signInWithGoogle() async{
    final firebase = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    final res = await googleSignIn.signIn();

    final auth = await res?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken
    );

    final firebaseAuth = await firebase.signInWithCredential(credential);

    return firebaseAuth;
  }

  @override
  Future<bool> checkLoggedIn() async{
    final firebase = FirebaseAuth.instance;

    final user = firebase.currentUser;

    return user != null;
  }

  @override
  Future<List<NotificationModel>> getNotificationList() async{
    final firebase = FirebaseFirestore.instance.collection("notifiche");
    List<NotificationModel> list = [];
    final collection = await firebase.get();
    for (var element in collection.docs) {
      list.add(
        NotificationModel(
          title: element.get("title"),
          sentBy: element.get("sentBy"),
          sentByUid: element.get("sentByUid"),
          date: dateUtils.parseStringToDateTime(element.get("date")),
          position: element.get("position"),
          floor: element.get("floor"),
          id: element.id,
          room: element.get("room"),
          note: element.get("note")
        )
      );
    }
    return list;
  }

  @override
  Future<void> addNotification() async{
    final firebase = FirebaseFirestore.instance.collection("notifiche");
    await firebase.add({
      "titolo": "esempio",
      "inviato da": 192837
    });
  }

  @override
  User? getCurrentUser() {
    final firebase = FirebaseAuth.instance;

    return firebase.currentUser;
  }

  @override
  Future<bool> editEmail(String? email) async {
    final firebase = FirebaseAuth.instance;

    if(email?.isNotEmpty == true && email != null) {
      await firebase.currentUser?.updateEmail(email);
      return firebase.currentUser?.email == email;
    }else{
      return false;
    }
  }

}