import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/create_delivery_order_params.dart';
import '../../../../domain/entities/params/digital_gold/post_payment_delivery_params.dart';
import '../../../../domain/entities/params/digital_gold/post_payment_params.dart';
import '../../../../domain/usecases/assisted_service/post_payment_assisted_service.dart';
import '../../../../domain/usecases/digital_gold/post_payment.dart';

part 'post_payment_state.dart';

@injectable
class PostPaymentCubit extends Cubit<PostPaymentState> {
  final PostDigitalGoldPayment _postDigitalGoldPayment;
  final PostPaymentAssistedService _postPaymentAssistedService;

  PostPaymentCubit(this._postDigitalGoldPayment, this._postPaymentAssistedService) : super(PostPaymentInitial());

  void processDigitalGoldPayment({required String orderId, required String paymentId, required String status}) async {
    emit(PostPaymentLoading());
    final response = await _postDigitalGoldPayment(PostPaymentParams(orderId: orderId, paymentId: paymentId, status: status));
    emit(response.fold((l) => PostPaymentFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => const PostPaymentSuccess()));
  }

  void processDeliveryPayment({
    required String orderId,
    required String paymentId,
    required String status,
    required CreateDeliveryOrderParams dOP,
  }) async {
    emit(PostPaymentLoading());
    final response = await _postDigitalGoldPayment(PostPaymentDeliveryParams(
        orderId: orderId,
        paymentId: paymentId,
        status: status,
        isShippingSameAsBilling: dOP.isShippingSameAsBilling,
        billingUserAddressId: dOP.billingUserAddressId,
        products: dOP.products,
        shippingUserAddressId: dOP.shippingUserAddressId));

    emit(response.fold((l) => PostPaymentFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => const PostPaymentSuccess()));
  }

  void processAssistedServicePayment({required String orderId, required String paymentId, required String status}) async {
    emit(PostPaymentLoading());
    final response = await _postPaymentAssistedService(PostPaymentParams(orderId: orderId, paymentId: paymentId, status: status));
    emit(response.fold((l) => PostPaymentFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => PostPaymentSuccess(user: r)));
  }
}
