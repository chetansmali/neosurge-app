part of 'lamf_get_user_cubit.dart';

abstract class LamfGetUserState extends Equatable {
  const LamfGetUserState();
}

class LamfGetUserInitial extends LamfGetUserState {
  @override
  List<Object> get props => [];
}

class LamfGetUserLoading extends LamfGetUserState {
  @override
  List<Object> get props => [];
}

class LamfGetUserSuccess extends LamfGetUserState {
  final GetLoanUserDetails getLoanUserDetails;

  const LamfGetUserSuccess(this.getLoanUserDetails);

  @override
  List<Object> get props => [];
}

class LamfGetUserFailure extends LamfGetUserState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfGetUserFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
