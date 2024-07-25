part of 'get_business_houses_cubit.dart';

sealed class GetBusinessHousesState extends Equatable {
  const GetBusinessHousesState();
}

final class GetBusinessHousesInitial extends GetBusinessHousesState {
  @override
  List<Object> get props => [];
}

final class GetBusinessHousesLoading extends GetBusinessHousesState {
  @override
  List<Object> get props => [];
}

final class GetBusinessHousesSuccess extends GetBusinessHousesState {
  final List<BusinessHouseModel> businessHouses;

  const GetBusinessHousesSuccess({required this.businessHouses});

  @override
  List<Object> get props => [businessHouses];
}

final class GetBusinessHousesFailure extends GetBusinessHousesState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetBusinessHousesFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
