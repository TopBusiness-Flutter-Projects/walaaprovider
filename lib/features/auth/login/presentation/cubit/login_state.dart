
abstract class LoginState {}

class LoginInitial extends LoginState {}


class OnLoginVaild extends LoginState {
}
class OnLoginVaildFaild extends LoginState {
}


class LoginLoading extends LoginState {}
class LoginError extends LoginState {}
class LoginErrorMessages extends LoginState {}

