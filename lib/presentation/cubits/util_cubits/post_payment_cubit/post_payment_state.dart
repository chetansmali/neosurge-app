part of 'post_payment_cubit.dart';

abstract class PostPaymentState extends Equatable {
  const PostPaymentState();
}

class PostPaymentInitial extends PostPaymentState {
  @override
  List<Object> get props => [];
}

class PostPaymentLoading extends PostPaymentState {
  @override
  List<Object> get props => [];
}

class PostPaymentSuccess extends PostPaymentState {
  final User? user;

  const PostPaymentSuccess({this.user});

  @override
  List<Object> get props => [];
}

class PostPaymentFailure extends PostPaymentState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const PostPaymentFailure({
    this.errorMessage,
    required this.appErrorType,
  });

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
