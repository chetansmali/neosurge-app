import 'package:dartz/dartz.dart';

import '../../data/models/digital_gold/checkout_delivery_response_model.dart';
import '../../data/models/digital_gold/checkout_rates_model.dart';
import '../../data/models/digital_gold/create_order_response_model.dart';
import '../../data/models/digital_gold/delivery_product_model.dart';
import '../../data/models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../data/models/digital_gold/dg_transaction_response_model.dart';
import '../../data/models/digital_gold/gold_silver_rates_model.dart';
import '../../data/models/digital_gold/gold_user.dart';
import '../entities/app_error.dart';
import '../entities/digital_gold/digital_gold_graph_response_entity.dart';

abstract class DigitalGoldRepository {
  Future<Either<AppError, void>> createGoldUser();

  Future<Either<AppError, void>> acceptTerms();

  Future<Either<AppError, void>> createGoldKYC();

  Future<Either<AppError, void>> addBankAccount();

  Future<Either<AppError, List<DigitalGoldGraphResponse>>>
      getDigitalGoldGraphData();

  Future<Either<AppError, GoldSilverRatesModel>> getGoldSilverRates();

  Future<Either<AppError, CheckoutRatesModel>> getCheckoutRates(
      Map<String, dynamic> params);

  Future<Either<AppError, CheckoutDeliveryResponseModel>> checkOutDeliveryOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, CreateOrderResponseModel>> createOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> postPayment(Map<String, dynamic> params);

  Future<Either<AppError, GoldUser>> getGoldUser();

  Future<Either<AppError, List<DgTransactionResponseModel>>> getDgTransactions(
      Map<String, dynamic> params);

  Future<Either<AppError, List<DgDeliveryTransactionResponseModel>>>
      getDgDeliveryTransactions(Map<String, dynamic> params);

  Future<Either<AppError, List<DeliveryProductModel>>>
      getDeliveryProductsByMetalType(Map<String, dynamic> params);

  Future<Either<AppError, void>> sellGoldSilver(Map<String, dynamic> params);
}
