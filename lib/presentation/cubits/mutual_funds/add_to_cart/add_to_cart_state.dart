part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();
}

class AddToCartInitial extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartLoading extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartSuccess extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartFail extends AddToCartState {
  final AppErrorType errorType;
  final String? error;

  const AddToCartFail({
    required this.errorType,
    required this.error,
  });

  @override
  List<Object> get props => [errorType, error ?? ''];
}
