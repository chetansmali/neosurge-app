part of 'fetch_smart_indices_cubit.dart';

abstract class FetchSmartIndicesState extends Equatable {
  const FetchSmartIndicesState();
}

final class FetchSmartIndicesInitial extends FetchSmartIndicesState {
  @override
  List<Object> get props => [];
}

class FetchSmartIndicesLoading extends FetchSmartIndicesState {
  @override
  List<Object> get props => [];
}

class FetchSmartIndicesSuccess extends FetchSmartIndicesState {
  final SmartFilterIndicesDetails smartFilterIndicesDetails;
  const FetchSmartIndicesSuccess(this.smartFilterIndicesDetails);

  @override
  List<Object> get props => [smartFilterIndicesDetails];
}

class FetchSmartIndicesFailure extends FetchSmartIndicesState {
  final String? errorMessage;
  final AppErrorType errorType;

  const FetchSmartIndicesFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
