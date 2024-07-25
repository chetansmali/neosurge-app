part of 'edit_cart_cubit.dart';

abstract class EditCartState extends Equatable {
  const EditCartState();
}

class EditCartInitial extends EditCartState {
  @override
  List<Object> get props => [];
}

class EditCartLoading extends EditCartState {
  @override
  List<Object> get props => [];
}

class EditCartSuccess extends EditCartState {
  @override
  List<Object> get props => [];
}

class EditCartFail extends EditCartState {
  final AppErrorType errorType;
  final String? error;

  const EditCartFail({
    required this.errorType,
    required this.error,
  });

  @override
  List<Object> get props => [errorType, error ?? ''];
}
