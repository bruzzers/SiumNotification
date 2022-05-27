// coverage:ignore-file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/features/login/data/login_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class LoginRepositoryImpl extends LoginRepository{
  final FirebaseUtils firebaseUtils;

  LoginRepositoryImpl(this.firebaseUtils);
  @override
  Future<UserCredential?> login(String? email, String? password) async{
    final res = firebaseUtils.login(email, password);

    return res;
  }

  @override
  Future<UserCredential> loginWithGoogle() async{
    final res = await firebaseUtils.signInWithGoogle();

    return res;
  }

  @override
  Future<bool> isLoggedIn() async{
    final res = await firebaseUtils.checkLoggedIn();

    return res;
  }

  @override
  User? getCurrentUser() {
    return firebaseUtils.getCurrentUser();
  }

}