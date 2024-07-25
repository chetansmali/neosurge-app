import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../data/models/digital_gold/delivery_product_model.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/digital_gold/create_delivery_order_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/digital_gold/checkout_delivery_order_cubit/checkout_delivery_order_cubit.dart';
import '../../cubits/digital_gold/create_delivery_order_cubit/create_delivery_order_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class DeliveryCheckoutScreen extends StatelessWidget {
  final CreateDeliveryOrderParams createDeliveryOrderParams;
  final DeliveryProductModel deliveryProduct;

  const DeliveryCheckoutScreen(
      {Key? key,
      required this.createDeliveryOrderParams,
      required this.deliveryProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _confirmCancel(context),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Confirm Order'),
          ),
          body: BlocConsumer<CheckoutDeliveryOrderCubit,
              CheckoutDeliveryOrderState>(
            listener: (context, state) {
              if (state is CheckoutDeliveryOrderSuccess) {
                context
                    .read<CreateDeliveryOrderCubit>()
                    .createDeliveryOrder(createDeliveryOrderParams);
              }
            },
            builder: (context, state) {
              if (state is CheckoutDeliveryOrderFailure) {
                return AppErrorWidget(
                    errorType: state.appErrorType, error: state.errorMessage);
              }
              if (state is CheckoutDeliveryOrderSuccess) {
                return BlocBuilder<CreateDeliveryOrderCubit,
                    CreateDeliveryOrderState>(
                  builder: (context, subState) {
                    if (subState is CreateDeliveryOrderLoading) {
                      return const Center(
                        child: CustomLoader(),
                      );
                    }
                    if (subState is CreateDeliveryOrderFailure) {
                      return AppErrorWidget(
                          errorType: subState.appErrorType,
                          error: subState.errorMessage);
                    }
                    if (subState is CreateDeliveryOrderSuccess) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.neutral[50]!)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Order details',
                                                style:
                                                    baseTextStyle16500.copyWith(
                                                        color: AppColors
                                                            .neutral[400]),
                                              ),
                                            ),
                                            deliveryProduct.metalType ==
                                                    MetalType.gold
                                                ? Assets.pngs.goldCoin.image(
                                                    height: 40.0, width: 40.0)
                                                : Assets.pngs.silverCoin.image(
                                                    height: 40.0, width: 40.0),
                                          ],
                                        ),
                                        Divider(color: AppColors.neutral[50]),
                                        const Gap(12.0),
                                        TwoRowText(
                                          title: 'Quantity',
                                          subtitle:
                                              '${state.checkoutDeliveryResponseModel.quantity} g',
                                          titleStyle:
                                              baseTextStyle14400.copyWith(
                                                  color:
                                                      AppColors.neutral[400]),
                                          subtitleStyle:
                                              baseTextStyle14500.copyWith(
                                                  color:
                                                      AppColors.neutral[500]),
                                        ),
                                        const Gap(8.0),
                                        TwoRowText(
                                          title: 'Amount payable',
                                          subtitle: Utils.compactCurrency(state
                                              .checkoutDeliveryResponseModel
                                              .amountPayable),
                                          titleStyle:
                                              baseTextStyle14400.copyWith(
                                                  color:
                                                      AppColors.neutral[400]),
                                          subtitleStyle:
                                              baseTextStyle14500.copyWith(
                                                  color:
                                                      AppColors.neutral[500]),
                                        ),
                                        const Gap(8.0),
                                      ],
                                    ),
                                  ),
                                  const Gap(32.0),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Shipping Address'),
                                  ),
                                  const Gap(12.0),
                                  AddressInfoCard(
                                      isSelected: true,
                                      addressDetails: state
                                          .checkoutDeliveryResponseModel
                                          .shippingUserAddressDetail,
                                      index: null),
                                  const Gap(32),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Billing Address'),
                                  ),
                                  const Gap(12.0),
                                  AddressInfoCard(
                                      isSelected: true,
                                      addressDetails: state
                                          .checkoutDeliveryResponseModel
                                          .billingUserAddressDetail,
                                      index: null),
                                  const Gap(40),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.deliveryPayment,
                                  arguments: DeliveryPaymentArgs(
                                      createOrderResponseModel:
                                          subState.orderResponse,
                                      createDeliveryOrderParams:
                                          createDeliveryOrderParams)),
                              child: const Text('Proceed to Pay'),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }
              return const Center(child: CustomLoader());
            },
          )),
    );
  }

  Future<bool> _confirmCancel(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Are you sure?'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              content: const Text('Do you want to cancel the order?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  child: const Text('Yes'),
                ),
              ],
            ));

    return Future.value(false);
  }
}
