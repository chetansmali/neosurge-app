import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../common/validators.dart';
import '../../../../constants/meta_strings.dart';
import '../../../../data/data_sources/remote/digital_gold_remote_data_source.dart';
import '../../../../data/models/user/address_details_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/params/digital_gold/add_delivery_address_params.dart';
import '../../../cubits/account/add_delivery_address_cubit/add_delivery_address_cubit.dart';
import '../../../cubits/account/delivery_address_cubit/delivery_address_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../widgets/label_text.dart';
import '../../loading_screen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({
    Key? key,
    this.args,
  }) : super(key: key);
  final AddAddressScreenArgs? args;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _pincodeController;
  late final TextEditingController _mobileController;

  DGUserCity? _city;
  DGUserState? _state;

  @override
  void initState() {
    super.initState();
    _fullNameController =
        TextEditingController(text: widget.args?.fullName ?? '');
    _addressController =
        TextEditingController(text: widget.args?.address ?? '');
    _pincodeController =
        TextEditingController(text: widget.args?.pincode ?? '');
    _mobileController =
        TextEditingController(text: widget.args?.mobileNumber ?? '');
    _city = widget.args?.city;
    _state = widget.args?.state;
    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: BlocListener<AddDeliveryAddressCubit, AddDeliveryAddressState>(
        listener: (context, state) {
          if (state is AddDeliveryAddressFailure) {
            Utils.showErrorAlert(
              context,
              Utils.getErrorMessage(
                  errorType: state.appErrorType, msg: state.errorMessage),
            );
          }
          if (state is AddDeliveryAddressSuccess) {
            context
                .read<DeliveryAddressCubit>()
                .addAddress(state.addressDetailsModel);
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add New Address'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const LabelText(label: 'Full Name'),
                          TextFormField(
                            controller: _fullNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyFullNameField, value),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z ]'))
                            ],
                          ),
                          const Gap(20),
                          const LabelText(label: 'Mobile Number'),
                          TextFormField(
                            controller: _mobileController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration:
                                const InputDecoration(prefixText: '+91 '),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'\d')),
                              LengthLimitingTextInputFormatter(10)
                            ],
                            validator: Validators.validateMobileNumber,
                          ),
                          const Gap(20),
                          const LabelText(label: 'Address'),
                          TextFormField(
                            controller: _addressController,
                            maxLines: 4,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: Validators.validateAddressField,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z0-9 /,.-]"))
                            ],
                          ),
                          const Gap(20),
                          const LabelText(label: 'Pincode'),
                          TextFormField(
                            controller: _pincodeController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: Validators.validatePinCode,
                          ),
                          const Gap(20),
                          const LabelText(label: 'State'),
                          DropdownSearch<DGUserState>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  CustomStyles.dropDownDecoration,
                            ),
                            itemAsString: (DGUserState state) => state.name,
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  decoration:
                                      CustomStyles.dropDownDecoration.copyWith(
                                prefixIcon: const Icon(Icons.search_rounded),
                                suffixIcon: const SizedBox.shrink(),
                              )),
                              containerBuilder: (context, popupWidget) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12.0),
                                  child: popupWidget,
                                );
                              },
                            ),
                            selectedItem: _state,
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyStateDropDown,
                                value?.stateId),
                            onChanged: (DGUserState? state) {
                              setState(() {
                                if (_state == state) {
                                  return;
                                }
                                _state = state;
                                _city = null;
                              });
                            },
                            asyncItems: (_) =>
                                getIt<DigitalGoldRemoteDataSource>()
                                    .getUserStates(),
                          ),
                          const Gap(20),
                          if (_state != null) ...[
                            const LabelText(label: 'City'),
                            DropdownSearch<DGUserCity>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration:
                                      CustomStyles.dropDownDecoration),
                              itemAsString: (DGUserCity city) => city.name,
                              selectedItem: _city,
                              validator: (value) =>
                                  Validators.validateEmptyField(
                                      ValidatorStrings.emptyCityDropDown,
                                      value?.cityId),
                              onChanged: (DGUserCity? city) =>
                                  setState(() => _city = city),
                              popupProps: PopupProps.modalBottomSheet(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                    decoration: CustomStyles.dropDownDecoration
                                        .copyWith(
                                  prefixIcon: const Icon(Icons.search_rounded),
                                  suffixIcon: const SizedBox.shrink(),
                                )),
                                containerBuilder: (context, popupWidget) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 12.0),
                                    child: popupWidget,
                                  );
                                },
                              ),
                              asyncItems: (_) =>
                                  getIt<DigitalGoldRemoteDataSource>()
                                      .getUserCities(
                                          {'state_id': _state!.stateId}),
                            ),
                          ],
                          const Gap(20.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context
                          .read<AddDeliveryAddressCubit>()
                          .addDeliveryAddress(AddDeliveryAddressParams(
                            address: _addressController.text.trim(),
                            pincode: _addressController.text.trim(),
                            cityId: _city!.cityId,
                            fullName: _addressController.text.trim(),
                            mobileNumber: _addressController.text.trim(),
                          ));
                    }
                  },
                  child: const Text('Save Address')),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
