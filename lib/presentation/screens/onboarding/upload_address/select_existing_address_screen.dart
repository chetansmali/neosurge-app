import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../constants/dropdown_constants.dart';
import '../../../../data/models/kyc/get_decentro_address_model.dart';
import '../../../../data/models/kyc/get_pincode_data_model.dart';
import '../../../../domain/entities/params/kyc/get_pincode_data_params.dart';
import '../../../../domain/entities/params/kyc/upload_address_details_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/onboarding/get_data_from_pincode/get_pincode_data_cubit.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_address_details/upload_address_details_cubit.dart';

class SelectExistingAddress extends StatefulWidget {
  const SelectExistingAddress({
    super.key,
    required this.decentroAddressList,
    required this.onAddNewAddress,
  });

  final List<GetDecentroAddressModel> decentroAddressList;
  final VoidCallback onAddNewAddress;

  @override
  State<SelectExistingAddress> createState() => _SelectExistingAddressState();
}

class _SelectExistingAddressState extends State<SelectExistingAddress> {
  int _selectedAddressIndex = 0;

  late PinCodeDataModel _pinCodeDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<GetPinCodeDataCubit, GetPincodeDataState>(
              listener: (context, state) {
                if (state is GetPincodeDataSuccess) {
                  _pinCodeDataModel = state.pinCodeData;

                  // log('pinCodeData: ${DropDownConstants.statesOfIndiaList.firstWhere(
                  //       (element) =>
                  //           element.name.toLowerCase() ==
                  //           _pinCodeDataModel.stateName.toLowerCase(),
                  //     ).value}');

                  context
                      .read<UploadAddressDetailsCubit>()
                      .uploadAddressDetails(
                        UploadAddressDetailsParams(
                          permAddressLine1: _pinCodeDataModel.countryName,
                          permAddressLine2: widget
                              .decentroAddressList[_selectedAddressIndex]
                              .address
                              .trim(),
                          permCity: _pinCodeDataModel.city,
                          permPincode: int.parse(
                            widget.decentroAddressList[_selectedAddressIndex]
                                .postal,
                          ),
                          permState: DropDownConstants.statesOfIndiaList
                              .firstWhere(
                                (element) =>
                                    element.name.toLowerCase() ==
                                    _pinCodeDataModel.stateName.toLowerCase(),
                              )
                              .value,
                          permSameAsCurr: true,
                          currAddressLine1: null,
                          currAddressLine2: null,
                          currCity: null,
                          currPincode: null,
                          currState: null,
                        ),
                      );
                }
              },
              builder: (context, getPinCodeDataState) {
                return BlocConsumer<UploadAddressDetailsCubit,
                    UploadAddressDetailsState>(
                  listener: (context, state) {
                    if (state is UploadAddressDetailsSuccess &&
                        !state.isFetch) {
                      context.read<OnboardingPageCubit>().goToNextPage();
                      return;
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state is UploadAddressDetailsLoading ||
                            getPinCodeDataState is GetPincodeDataLoading) {
                          return;
                        }

                        context.read<GetPinCodeDataCubit>().getPincodeData(
                              GetPincodeDataParams(
                                pinCode: widget
                                    .decentroAddressList[_selectedAddressIndex]
                                    .postal,
                              ),
                            );
                      },
                      child: state is UploadAddressDetailsLoading ||
                              getPinCodeDataState is GetPincodeDataLoading
                          ? Assets.animations.loading.lottie()
                          : const Text('Continue'),
                    );
                  },
                );
              },
            ),
            const Gap(8),
            TextButton(
              onPressed: widget.onAddNewAddress,
              child: const Text('Add New Address'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            const Text(
              'Confirm Address',
              style: TextStyle(
                color: Color(0xFF151A20),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(4),
            const Text(
              'The address is fetched as per your KYC details.',
              style: TextStyle(
                color: Color(0xFF47586E),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(16),
            const Text(
              'Choose your primary address',
              style: TextStyle(
                color: Color(0xFF151A20),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: widget.decentroAddressList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAddressIndex = index;
                          });
                        },
                        child: Row(
                          children: [
                            Radio.adaptive(
                              value: int.parse(widget
                                      .decentroAddressList[index].sequence) -
                                  1,
                              groupValue: _selectedAddressIndex,
                              onChanged: (val) {},
                            ),
                            const Gap(8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBEBEB),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${widget.decentroAddressList[index].address}, ${widget.decentroAddressList[index].state}, INDIA. - ${widget.decentroAddressList[index].postal}',
                                        style: const TextStyle(
                                          color: Color(0xFF47586E),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
