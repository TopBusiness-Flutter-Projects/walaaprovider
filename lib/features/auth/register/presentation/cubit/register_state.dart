
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}


class OnRegisterVaild extends RegisterState {
}
class OnRegisterVaildFaild extends RegisterState {
}


class RegisterLoading extends RegisterState {}
class RegisterError extends RegisterState {}
class RegisterErrorMessages extends RegisterState {}

