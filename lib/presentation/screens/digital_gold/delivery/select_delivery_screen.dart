import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../data/models/user/address_details_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/checkout_delivery_order_params.dart';
import '../../../../domain/entities/params/digital_gold/create_delivery_order_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/delivery_address_cubit/delivery_address_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/address_info_card.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';

class SelectDeliveryScreen extends StatefulWidget {
  final DeliveryProductArgs dP;

  const SelectDeliveryScreen({Key? key, required this.dP}) : super(key: key);

  @override
  State<SelectDeliveryScreen> createState() => _SelectDeliveryScreenState();
}

class _SelectDeliveryScreenState extends State<SelectDeliveryScreen> {
  bool _isBillingSame = true;
  DeliveryAddressDetailsModel? _selectedBillingAddress;
  DeliveryAddressDetailsModel? _selectedShippingAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
          builder: (context, state) {
            if (state is DeliveryAddressLoading) {
              return const Center(child: CustomLoader());
            }
            if (state is DeliveryAddressLoadError) {
              return Center(
                child: AppErrorWidget(
                    errorType: state.appErrorType, error: state.errorMessage),
              );
            }
            if (state is DeliveryAddressLoaded) {
              if (state.addressList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Assets.svgs.emptyAddress.svg(height: 200),
                      ),
                      const Text('No Saved Address Found'),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, Routes.addDeliveryAddress),
                        child: const Text('Add New Address'),
                      )
                    ],
                  ),
                );
              }
              final shippingAddressList = _selectedBillingAddress == null
                  ? state.addressList
                  : state.addressList
                      .where((element) =>
                          element.id != _selectedBillingAddress!.id)
                      .toList();
              final billingAddressList = _selectedShippingAddress == null
                  ? state.addressList
                  : state.addressList
                      .where((element) =>
                          element.id != _selectedShippingAddress!.id)
                      .toList();
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Address',
                            style: baseTextStyle14400.copyWith(
                                color: Colors.black),
                          ),
                          const Gap(16),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Gap(20.0),
                            itemCount: shippingAddressList.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  if (_selectedShippingAddress ==
                                      shippingAddressList[index]) {
                                    _selectedShippingAddress = null;
                                  } else {
                                    _selectedShippingAddress =
                                        shippingAddressList[index];
                                  }
                                });
                              },
                              child: AddressInfoCard(
                                onEditAddress: () => Navigator.pushNamed(
                                  context,
                                  Routes.addDeliveryAddress,
                                  arguments: AddAddressScreenArgs(
                                    fullName:
                                        shippingAddressList[index].fullName,
                                    address: shippingAddressList[index].address,
                                    mobileNumber:
                                        shippingAddressList[index].mobileNumber,
                                    pincode: shippingAddressList[index].pincode,
                                    city: shippingAddressList[index].city,
                                    state: shippingAddressList[index].state,
                                  ),
                                ),
                                addressDetails: shippingAddressList[index],
                                isSelected: _selectedShippingAddress ==
                                    shippingAddressList[index],
                              ),
                            ),
                          ),
                          const Gap(20.0),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, Routes.addDeliveryAddress),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_circle_rounded,
                                  color: AppColors.primaryColor,
                                  size: 24.0,
                                ),
                                const Gap(8.0),
                                Text(
                                  'Add new address',
                                  style: baseTextStyle14400.copyWith(
                                      color: AppColors.neutral[300]),
                                ),
                              ],
                            ),
                          ),
                          const Gap(32),
                          Text(
                            'Billing Address',
                            style: baseTextStyle14400.copyWith(
                                color: Colors.black),
                          ),
                          const Gap(16),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Gap(20.0),
                            itemCount: billingAddressList.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  if (_selectedBillingAddress ==
                                      billingAddressList[index]) {
                                    _selectedBillingAddress = null;
                                  } else {
                                    _selectedBillingAddress =
                                        billingAddressList[index];
                                  }
                                });
                              },
                              child: AddressInfoCard(
                                onEditAddress: () => Navigator.pushNamed(
                                  context,
                                  Routes.addDeliveryAddress,
                                  arguments: AddAddressScreenArgs(
                                    fullName:
                                        billingAddressList[index].fullName,
                                    address: billingAddressList[index].address,
                                    mobileNumber:
                                        billingAddressList[index].mobileNumber,
                                    pincode: billingAddressList[index].pincode,
                                    city: billingAddressList[index].city,
                                    state: billingAddressList[index].state,
                                  ),
                                ),
                                addressDetails: billingAddressList[index],
                                isSelected: _selectedBillingAddress ==
                                    billingAddressList[index],
                              ),
                            ),
                          ),
                          const Gap(20.0),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, Routes.addDeliveryAddress),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add_circle_rounded,
                                  color: AppColors.primaryColor,
                                  size: 24.0,
                                ),
                                const Gap(8.0),
                                Text(
                                  'Add new address',
                                  style: baseTextStyle14400.copyWith(
                                      color: AppColors.neutral[300]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  CheckboxListTile(
                    value: _isBillingSame,
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    onChanged: (value) => setState(() {
                      _isBillingSame = value!;
                      if (value) {
                        _selectedBillingAddress = null;
                      }
                    }),
                    visualDensity: VisualDensity.compact,
                    title:
                        const Text('Billing Address same as Shipping Address?'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_selectedShippingAddress == null) {
                            Utils.showWarningAlert(
                                context, 'Please select a shipping address');
                            return;
                          }
                          if (!_isBillingSame &&
                              _selectedBillingAddress == null) {
                            Utils.showWarningAlert(
                                context, 'Please select a billing address');
                            return;
                          }
                          final dP = widget.dP.deliveryProductModel;
                          Navigator.pushNamed(
                            context,
                            Routes.deliveryCheckOut,
                            arguments: DeliveryCheckoutArgs(
                              deliveryProductModel: dP,
                              createDeliveryOrderParams:
                                  CreateDeliveryOrderParams(
                                metalType: dP.metalType,
                                transactionType: DGTransactionType.delivery,
                                shippingUserAddressId:
                                    _selectedShippingAddress!.userAddressId,
                                billingUserAddressId: _isBillingSame
                                    ? _selectedShippingAddress!.userAddressId
                                    : _selectedBillingAddress!.userAddressId,
                                isShippingSameAsBilling: _isBillingSame,
                                products: [
                                  DeliveryProduct(
                                      sku: dP.sku, quantity: widget.dP.quantity)
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text('Checkout')),
                  ),
                  const Gap(10),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
