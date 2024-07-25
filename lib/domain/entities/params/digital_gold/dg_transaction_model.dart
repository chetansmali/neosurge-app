import 'package:flutter/cupertino.dart';

import '../../../../common/common.dart';
import '../../../../data/models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../../../data/models/digital_gold/dg_transaction_response_model.dart';
import '../../../../presentation/theme/app_colors.dart';
import '../../enums.dart';

class DgTransactionModel {
  final DgTransactionResponseModel? transaction;
  final DgDeliveryTransactionResponseModel? deliveryTransaction;

  DateTime get transactionDate =>
      transaction?.createdAt ?? deliveryTransaction!.createdAt;

  DateTime get updatedDate =>
      transaction?.updatedAt ?? deliveryTransaction!.updatedAt;

  MetalType get metalType =>
      transaction?.metalType ??
      deliveryTransaction!.deliveryGoldSilverProduct[0].sku.metalType;

  double get totalAmount =>
      transaction?.totalAmount ?? deliveryTransaction!.totalAmountPaid;

  double get totalWeight =>
      transaction?.quantity ?? deliveryTransaction!.totalWeight;

  String get transactionId =>
      transaction?.transactionId ?? deliveryTransaction!.transactionId;

  String? get invoiceUrl =>
      transactionType == DGTransactionType.buy ? transaction!.invoiceUrl : null;

  String get augmontStatus =>
      transaction?.augmontStatus ?? deliveryTransaction!.augmontStatus;

  Container get container => transactionType == DGTransactionType.buy
      ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.primary[50]),
          child: Text(
            'Buy',
            style: baseTextStyle12500.copyWith(color: AppColors.primaryColor),
          ),
        )
      : Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: transactionType == DGTransactionType.sell
                  ? AppColors.error[50]
                  : AppColors.primary[50]),
          child: Text(
            transactionType == DGTransactionType.sell ? 'Sell' : 'Delivery',
            style: baseTextStyle12500.copyWith(
                color: transactionType == DGTransactionType.sell
                    ? AppColors.errorRed
                    : AppColors.primaryColor),
          ),
        );

  DGTransactionType get transactionType => transaction != null
      ? transaction!.orderType == DGOrderType.buy
          ? DGTransactionType.buy
          : DGTransactionType.sell
      : DGTransactionType.delivery;

  DgTransactionModel({
    this.transaction,
    this.deliveryTransaction,
  }) : assert(transaction != null || deliveryTransaction != null);
}
