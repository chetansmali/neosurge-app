part of 'gold_user_cubit.dart';

abstract class GoldUserState extends Equatable {
  final GoldUser? goldUser;

  const GoldUserState({this.goldUser});
}

class GoldUserInitial extends GoldUserState {
  @override
  List<Object> get props => [];
}

class GoldUserLoading extends GoldUserState {
  @override
  List<Object> get props => [];
}

class GoldUserLoaded extends GoldUserState {
  const GoldUserLoaded(GoldUser goldUser) : super(goldUser: goldUser);

  @override
  List<Object> get props => [goldUser!];
}

class GoldUserLoadError extends GoldUserState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GoldUserLoadError({required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
