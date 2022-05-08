import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class FirebaseUtilsImpl extends FirebaseUtils{
  @override
  Future<UserCredential> registerUser(String? email, String? password) async{
    final firebase = FirebaseAuth.instance;

    final res =  await firebase.createUserWithEmailAndPassword(email: email ?? "", password: password ?? "");

    print("Firebase Res: ${res.toString()}");
    return res;
  }

}