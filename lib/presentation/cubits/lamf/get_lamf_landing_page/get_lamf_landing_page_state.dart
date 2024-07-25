part of 'get_lamf_landing_page_cubit.dart';

sealed class GetLamfLandingPageState extends Equatable {
  const GetLamfLandingPageState();
}

final class GetLamfLandingPageInitial extends GetLamfLandingPageState {
  @override
  List<Object> get props => [];
}

final class GetLamfLandingPageLoading extends GetLamfLandingPageState {
  @override
  List<Object> get props => [];
}

final class GetLamfLandingPageSuccess extends GetLamfLandingPageState {
  final GetImportLandingPageResponse getImportLandingPageResponse;

  const GetLamfLandingPageSuccess({required this.getImportLandingPageResponse});

  @override
  List<Object> get props => [getImportLandingPageResponse];
}

final class GetLamfLandingPageFailure extends GetLamfLandingPageState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const GetLamfLandingPageFailure(
      {this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
