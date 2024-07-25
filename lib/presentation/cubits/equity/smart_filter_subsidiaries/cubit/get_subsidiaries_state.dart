part of 'get_subsidiaries_cubit.dart';

sealed class GetSubsidiariesState extends Equatable {
  const GetSubsidiariesState();
}

final class GetSubsidiariesInitial extends GetSubsidiariesState {
  @override
  List<Object> get props => [];
}

final class GetSubsidiariesLoading extends GetSubsidiariesState {
  @override
  List<Object> get props => [];
}

final class GetSubsidiariesSuccess extends GetSubsidiariesState {
  final List<SubsidiaryModel> businessHouses;

  const GetSubsidiariesSuccess({required this.businessHouses});

  @override
  List<Object> get props => [businessHouses];
}

final class GetSubsidiariesFailure extends GetSubsidiariesState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetSubsidiariesFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
