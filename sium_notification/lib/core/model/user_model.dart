import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String? email;
  final String? userName;
  final String? errorDetail;

  @override
  List<Object?> get props => [email, userName, errorDetail];

  const UserModel({
    this.email,
    this.userName,
    this.errorDetail,
  });
}