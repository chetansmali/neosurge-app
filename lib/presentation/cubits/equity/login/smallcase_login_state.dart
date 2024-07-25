part of 'smallcase_login_cubit.dart';

abstract class SmallcaseLoginState extends Equatable {
  const SmallcaseLoginState();
}

class SmallcaseLoginInitial extends SmallcaseLoginState {
  @override
  List<Object> get props => [];
}

class SmallcaseLoginLoading extends SmallcaseLoginState {
  @override
  List<Object> get props => [];
}

class SmallcaseLoginSuccess extends SmallcaseLoginState {
  final SmallCaseLoginModel smallCaseLoginModel;

  const SmallcaseLoginSuccess({required this.smallCaseLoginModel});

  @override
  List<Object> get props => [smallCaseLoginModel];
}

class SmallcaseLoginFailure extends SmallcaseLoginState {
  final String? errorMessage;
  final AppErrorType errorType;

  const SmallcaseLoginFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
