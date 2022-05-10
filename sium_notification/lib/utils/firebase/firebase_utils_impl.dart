import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

}