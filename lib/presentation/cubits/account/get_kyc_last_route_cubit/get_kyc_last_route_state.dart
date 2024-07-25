part of 'get_kyc_last_route_cubit.dart';

abstract class GetKycLastRouteState extends Equatable {
  const GetKycLastRouteState();
}

class GetKycLastRouteInitial extends GetKycLastRouteState {
  @override
  List<Object> get props => [];
}

class GetKycLastRouteLoading extends GetKycLastRouteState {
  @override
  List<Object> get props => [];
}

class GetKycLastRouteLoaded extends GetKycLastRouteState {
  final KycLastRouteModel kycLastRouteModel;

  const GetKycLastRouteLoaded(this.kycLastRouteModel);

  @override
  List<Object> get props => [kycLastRouteModel];
}

class GetKycLastRouteError extends GetKycLastRouteState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetKycLastRouteError({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
