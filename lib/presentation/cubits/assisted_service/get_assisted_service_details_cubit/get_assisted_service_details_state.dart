part of 'get_assisted_service_details_cubit.dart';

abstract class GetAssistedServiceDetailsState extends Equatable {
  const GetAssistedServiceDetailsState();
}

class GetAssistedServiceDetailsInitial extends GetAssistedServiceDetailsState {
  @override
  List<Object> get props => [];
}

class GetAssistedServiceDetailsLoading extends GetAssistedServiceDetailsState {
  @override
  List<Object> get props => [];
}

class GetAssistedServiceDetailsSuccess extends GetAssistedServiceDetailsState {
  final AssistedServiceDetailsResponse response;

  const GetAssistedServiceDetailsSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class GetAssistedServiceDetailsFailure extends GetAssistedServiceDetailsState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const GetAssistedServiceDetailsFailure({
    this.errorMessage,
    required this.appErrorType,
  });

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
