import 'package:sium_notification/features/reset_password/repository/reset_password_repository.dart';
import 'package:sium_notification/utils/firebase/firebase_utils.dart';

class ResetPasswordRepositoryImpl extends ResetPasswordRepository{
  final FirebaseUtils firebaseUtils;


  ResetPasswordRepositoryImpl(this.firebaseUtils);

  @override
  Future<bool> resetPassword(String? email) async{
    return await firebaseUtils.resetPassword(email);
  }

}