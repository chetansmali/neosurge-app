part of 'is_scheme_present_cubit.dart';

abstract class IsSchemePresentState extends Equatable {
  const IsSchemePresentState();
}

class IsSchemePresentInitial extends IsSchemePresentState {
  @override
  List<Object> get props => [];
}

class IsSchemePresentLoading extends IsSchemePresentState {
  @override
  List<Object> get props => [];
}

class IsSchemePresentSuccess extends IsSchemePresentState {
  const IsSchemePresentSuccess(this.isSchemePresent);

  final bool isSchemePresent;

  @override
  List<Object> get props => [isSchemePresent];
}

class IsSchemePresentFail extends IsSchemePresentState {
  final AppErrorType errorType;
  final String? error;

  const IsSchemePresentFail({
    required this.errorType,
    required this.error,
  });

  @override
  List<Object> get props => [errorType, error ?? ''];
}
