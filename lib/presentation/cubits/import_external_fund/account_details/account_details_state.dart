part of 'account_details_cubit.dart';

abstract class AccountDetailsState extends Equatable {
  const AccountDetailsState();
}

class AccountDetailsInitial extends AccountDetailsState {
  @override
  List<Object> get props => [];
}

class AccountDetailsLoading extends AccountDetailsState {
  @override
  List<Object> get props => [];
}

class AccountDetailsLoaded extends AccountDetailsState {
  final AccountDetailsResponse accountDetailsResponse;

  const AccountDetailsLoaded({
    required this.accountDetailsResponse,
  });

  @override
  List<Object?> get props => [];
}

class AccountDetailsLoadError extends AccountDetailsState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const AccountDetailsLoadError(
      {required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}

class AccountDetailsChanged extends AccountDetailsState {
  final bool isBtnEnabled;

  const AccountDetailsChanged({
    required this.isBtnEnabled,
  });

  @override
  List<Object?> get props => [
        isBtnEnabled,
      ];
}
