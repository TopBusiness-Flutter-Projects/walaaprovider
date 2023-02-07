
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}


class OnEditProfileVaild extends EditProfileState {
}
class OnEditProfileVaildFaild extends EditProfileState {
}


class EditProfileLoading extends EditProfileState {}
class EditProfileError extends EditProfileState {}
class EditProfileErrorMessages extends EditProfileState {}
class AddProfilePickImageSuccess extends EditProfileState {}

