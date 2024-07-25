import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../common/common.dart';
import '../../data/models/user/address_details_model.dart';
import '../cubits/account/delete_delivery_address_cubit/delete_delivery_address_cubit.dart';
import '../cubits/account/delivery_address_cubit/delivery_address_cubit.dart';
import '../routes/route_arguments.dart';
import '../routes/routes.dart';
import '../theme/app_colors.dart';
import 'custom_loader.dart';

class AddressInfoCard extends StatelessWidget {
  final DeliveryAddressDetailsModel addressDetails;
  final int? index;
  final bool isSelected;
  final Function()? onEditAddress;

  const AddressInfoCard({
    super.key,
    required this.addressDetails,
    this.index,
    this.isSelected = false,
    this.onEditAddress,
  });

  @override
  Widget build(BuildContext context) {
    return index == null
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                border: Border.all(color: AppColors.primaryColor),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8, color: Colors.black.withOpacity(0.16))
                ]),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      addressDetails.fullName,
                      style: baseTextStyle14500.copyWith(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (onEditAddress != null) const Gap(12.0),
                    if (onEditAddress != null)
                      GestureDetector(
                        onTap: onEditAddress,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Edit Address',
                            style: baseTextStyle12400.copyWith(
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    const Spacer(),
                    const Gap(12.0),
                    isSelected
                        ? const Icon(
                            Icons.check_circle_rounded,
                            size: 20.0,
                            color: AppColors.primaryColor,
                          )
                        : Icon(
                            Icons.check_circle_outline_rounded,
                            size: 20.0,
                            color: AppColors.neutral[200],
                          ),
                  ],
                ),
                const Gap(8.0),
                Text(
                  '${addressDetails.address}, ${addressDetails.city.name} - ${addressDetails.pincode}',
                  style: baseTextStyle14400.copyWith(
                      color: AppColors.neutral[300]),
                ),
                const Gap(8.0),
                Text('+91 ${addressDetails.mobileNumber}',
                    style: baseTextStyle14400.copyWith(
                        color: AppColors.neutral[300])),
              ],
            ),
          )
        : BlocListener<DeleteDeliveryAddressCubit, DeleteDeliveryAddressState>(
            listener: (context, state) {
              if (state is DeleteDeliveryAddressSuccess) {
                Navigator.pop(context);
                context.read<DeliveryAddressCubit>().deleteAddress(index!);
              }
              if (state is DeleteDeliveryAddressLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: const Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomLoader(),
                            Text(
                              'Deleting...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (state is DeleteDeliveryAddressFailure) {
                Navigator.pop(context);
                Utils.showErrorAlert(
                    context,
                    Utils.getErrorMessage(
                        msg: state.errorMessage,
                        errorType: state.appErrorType));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8, color: Colors.black.withOpacity(0.08))
                ],
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          addressDetails.fullName,
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[400]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.addDeliveryAddress,
                          arguments: AddAddressScreenArgs(
                            fullName: addressDetails.fullName,
                            address: addressDetails.address,
                            mobileNumber: addressDetails.mobileNumber,
                            pincode: addressDetails.pincode,
                            city: addressDetails.city,
                            state: addressDetails.state,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'EDIT',
                            style: baseTextStyle10500.copyWith(
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${addressDetails.address}, ${addressDetails.city.name} - ${addressDetails.pincode}',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[400]),
                        ),
                      ),
                      const Gap(60.0),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '+91 ${addressDetails.mobileNumber}',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[400]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context
                            .read<DeleteDeliveryAddressCubit>()
                            .deleteAddress(
                                index: index!, id: addressDetails.id),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'DELETE',
                            style: baseTextStyle10500.copyWith(
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
