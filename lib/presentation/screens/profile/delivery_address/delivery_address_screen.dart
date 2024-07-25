import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/get_it.dart';
import '../../../cubits/account/delete_delivery_address_cubit/delete_delivery_address_cubit.dart';
import '../../../cubits/account/delivery_address_cubit/delivery_address_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/address_info_card.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  late final DeliveryAddressCubit _deliveryAddressCubit;

  @override
  void initState() {
    super.initState();
    _deliveryAddressCubit = context.read<DeliveryAddressCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _deliveryAddressCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
      ),
      body: BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
        builder: (context, state) {
          if (state is DeliveryAddressLoading) {
            return const Center(child: CustomLoader());
          }
          if (state is DeliveryAddressLoadError) {
            return Center(
                child: AppErrorWidget(
                    errorType: state.appErrorType, error: state.errorMessage));
          }
          if (state is DeliveryAddressLoaded) {
            if (state.addressList.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text('No delivery address set!')),
                  ],
                ),
              );
            }
            return Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: ListView.builder(
                itemCount: state.addressList.length,
                itemBuilder: (_, index) {
                  return BlocProvider(
                    create: (context) => getIt<DeleteDeliveryAddressCubit>(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: AddressInfoCard(
                        addressDetails: state.addressList[index],
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.addDeliveryAddress),
            child: const Text('Add New Address')),
      ),
    );
  }
}
