part of 'retake_kyc_cubit.dart';

abstract class RetakeKycState extends Equatable {
  const RetakeKycState();
}

class RetakeKycInitial extends RetakeKycState {
  @override
  List<Object> get props => [];
}

class RetakeKycLoading extends RetakeKycState {
  @override
  List<Object> get props => [];
}

class RetakeKycSuccess extends RetakeKycState {
  @override
  List<Object> get props => [];
}

class RetakeKycError extends RetakeKycState {
  final String? error;
  final AppErrorType errorType;

  const RetakeKycError({this.error, required this.errorType});

  @override
  List<Object?> get props => [error, errorType];
}
