import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String? messsage;
  ServerFailure([this.messsage]);
}

class AuthFailure extends Failure {
  final String? messsage;
  AuthFailure([this.messsage]);
}

class UserNotLoggedInFailure extends Failure {
  final String? messsage;
  UserNotLoggedInFailure([this.messsage]);
}
