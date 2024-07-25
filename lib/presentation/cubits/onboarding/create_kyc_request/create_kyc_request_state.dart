part of 'create_kyc_request_cubit.dart';

abstract class CreateKycRequestState extends Equatable {
  const CreateKycRequestState();
}

class CreateKycRequestInitial extends CreateKycRequestState {
  @override
  List<Object> get props => [];
}

class CreateKycRequestLoading extends CreateKycRequestState {
  @override
  List<Object> get props => [];
}

class CreateKycRequestSuccess extends CreateKycRequestState {
  @override
  List<Object> get props => [];
}

class CreateKycRequestFailure extends CreateKycRequestState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CreateKycRequestFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
