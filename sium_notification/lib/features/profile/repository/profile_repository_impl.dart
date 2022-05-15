import 'package:firebase_auth/firebase_auth.dart';
import 'package:sium_notification/features/profile/repository/profile_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class ProfileRepositoryImpl extends ProfileRepository{
  final FirebaseUtils firebaseUtils;

  ProfileRepositoryImpl(this.firebaseUtils);

  @override
  Future<User?> getCurrentUser() async{
    return firebaseUtils.getCurrentUser();
  }

  @override
  Future<bool> updateEmail(String? email) async {
    return await firebaseUtils.editEmail(email);
  }

  @override
  Future<bool> updateUsername(String? username) async{
    return await firebaseUtils.editUsername(username);
  }

  @override
  Future<bool> updatePassword(String? password) async{
    return await firebaseUtils.editPassword(password);
  }

  @override
  Future<void> logout() async {
    await firebaseUtils.logout();
  }
}