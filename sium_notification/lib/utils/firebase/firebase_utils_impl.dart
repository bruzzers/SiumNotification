import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/core/model/user_model.dart';
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

}