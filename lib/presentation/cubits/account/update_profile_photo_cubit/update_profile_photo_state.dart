part of 'update_profile_photo_cubit.dart';

abstract class UpdateProfilePhotoState extends Equatable {
  const UpdateProfilePhotoState();
}

class UpdateProfilePhotoInitial extends UpdateProfilePhotoState {
  @override
  List<Object> get props => [];
}

class UpdateProfilePhotoLoading extends UpdateProfilePhotoState {
  @override
  List<Object> get props => [];
}

class UpdateProfilePhotoSuccess extends UpdateProfilePhotoState {
  final User user;

  const UpdateProfilePhotoSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateProfilePhotoFailure extends UpdateProfilePhotoState {
  final String? message;
  final AppErrorType errorType;

  const UpdateProfilePhotoFailure(this.errorType, this.message);

  @override
  List<Object?> get props => [errorType, message];
}
