import 'package:equatable/equatable.dart';

class CredentialModel extends Equatable{
  final String? email;
  final String? password;

  const CredentialModel({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}