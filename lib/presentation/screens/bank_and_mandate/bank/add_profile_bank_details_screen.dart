import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../common/validators.dart';
import '../../../../constants/dropdown_constants.dart';
import '../../../../constants/meta_strings.dart';
import '../../../../domain/entities/params/kyc/upload_bank_details_params.dart';
import '../../../cubits/account/add_user_bank_cubit/add_user_bank_cubit.dart';
import '../../../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../../../cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/label_text.dart';
import '../../loading_screen.dart';
import 'add_bank_error_screen.dart';

class AddProfileBankDetailsScreen extends StatefulWidget {
  const AddProfileBankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddProfileBankDetailsScreen> createState() =>
      _AddProfileBankDetailsScreenState();
}

class _AddProfileBankDetailsScreenState
    extends State<AddProfileBankDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _ifscController;
  String? _accHoldersName;
  String? _accNumber;
  DropDownItem? _accType;

  @override
  void initState() {
    _ifscController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Add New Bank '),
            ),
            body: BlocListener<AddUserBankCubit, AddUserBankState>(
              listener: (context, state) {
                // if (state is AddUserBankLoading) {
                //   showDialog(
                //     context: context,
                //     builder: (context) => WillPopScope(
                //       onWillPop: () async => false,
                //       child: const Dialog(
                //         child: Padding(
                //           padding: EdgeInsets.all(12.0),
                //           child: CustomLoader(),
                //         ),
                //       ),
                //     ),
                //     barrierDismissible: false,
                //   );
                //   return;
                // }
                if (state is AddUserBankSuccess) {
                  context.read<UserBankDetailsCubit>().addBank(state.userBank);
                  Navigator.of(context).pop();
                }
                if (state is AddUserBankError) {
                  Navigator.pushNamed(context, Routes.addBankErrorScreen,
                      arguments: AddBankErrorScreenArgs(
                          errorType: state.errorType, msg: state.errorMessage));
                }
              },
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const LabelText(label: 'Account holder\'s name'),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            onSaved: (value) => _accHoldersName = value,
                            initialValue: _accHoldersName,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyAccountHolderNameField,
                                value),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'name as per PAN'),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                //Allow only alphabets and one space between words
                                RegExp(r'[a-zA-Z .]'),
                              ),
                            ],
                          ),
                          const Gap(30),
                          const LabelText(label: 'Account Number'),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (value) => _accNumber = value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            maxLength: 18,
                            decoration: const InputDecoration(counterText: ''),
                            validator: Validators.validateBankAccountNumber,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                //Allow only numbers
                                RegExp(r'\d'),
                              ),
                            ],
                          ),
                          const Gap(30),
                          const LabelText(label: 'Account Type'),
                          DropdownSearch(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  CustomStyles.dropDownDecoration,
                            ),
                            items: DropDownConstants.accountTypeList,
                            selectedItem: _accType,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => Validators.validateEmptyField(
                                ValidatorStrings.emptyAccountType,
                                value?.toString()),
                            popupProps: PopupProps.menu(
                              itemBuilder:
                                  (context, DropDownItem item, isSelected) =>
                                      ListTile(
                                title: Text(item.name),
                                selected: _accType == item,
                              ),
                            ),
                            itemAsString: (DropDownItem? item) => item!.name,
                            onChanged: (DropDownItem? value) =>
                                _accType = value,
                          ),
                          const Gap(30),
                          const LabelText(label: 'IFSC Code'),
                          BlocBuilder<GetBankByIfscCubit, GetBankByIfscState>(
                            builder: (context, state) {
                              return TextFormField(
                                maxLength: 11,
                                controller: _ifscController,
                                textInputAction: TextInputAction.done,
                                validator: Validators.validateIFSCCode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                onChanged: (value) {
                                  context.read<GetBankByIfscCubit>().reset();
                                  if (value.length == 11) {
                                    FocusScope.of(context).unfocus();
                                    context
                                        .read<GetBankByIfscCubit>()
                                        .getBankDetailsByIfsc(ifscCode: value);
                                  }
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  suffixIcon: state is GetBankByIfscLoading
                                      ? Container(
                                          height: 24,
                                          width: 24,
                                          padding: const EdgeInsets.all(12),
                                          child: const CustomLoader(),
                                        )
                                      : state is GetBankByIfscSuccess
                                          ? const Icon(
                                              Icons.check,
                                              color: AppColors.green,
                                            )
                                          : state is GetBankByIfscFailure
                                              ? const Icon(
                                                  Icons.error,
                                                  color: AppColors.errorRed,
                                                )
                                              : null,
                                  errorText: _errorMessageGetter(state),
                                ),
                              );
                            },
                          ),
                          BlocBuilder<GetBankByIfscCubit, GetBankByIfscState>(
                            builder: (context, state) {
                              if (state is GetBankByIfscSuccess) {
                                final bankInfo = state.bank;
                                return Column(
                                  children: [
                                    const Gap(30),
                                    const LabelText(label: 'Bank Name'),
                                    TextFormField(
                                      initialValue: bankInfo.bankName,
                                      enabled: false,
                                    ),
                                    const Gap(30),
                                    const LabelText(label: 'Branch Name'),
                                    TextFormField(
                                      initialValue: bankInfo.branchName,
                                      enabled: false,
                                    ),
                                    const Gap(30),
                                    const LabelText(label: 'Branch State'),
                                    TextFormField(
                                      initialValue: bankInfo.state,
                                      enabled: false,
                                    ),
                                    const Gap(30),
                                    const LabelText(label: 'Branch Address'),
                                    TextFormField(
                                      initialValue: bankInfo.branchAddress,
                                      enabled: false,
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const Spacer(),
                          const Gap(20),
                          const Text(
                            'Note: Once you add a bank account, you will not be able to edit or delete it.',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          const Gap(20),
                          BlocSelector<GetBankByIfscCubit, GetBankByIfscState,
                              GetBankByIfscSuccess?>(
                            selector: (state) {
                              return state is GetBankByIfscSuccess
                                  ? state
                                  : null;
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    if (state != null) {
                                      context.read<AddUserBankCubit>().addBank(
                                          UploadBankDetailsParams(
                                              accountHolderName:
                                                  _accHoldersName!,
                                              accountNumber: _accNumber!,
                                              bankName: state.bank.bankName,
                                              branchName: state.bank.branchName,
                                              ifscCode: state.bank.ifscCode,
                                              accountType: _accType!.value,
                                              isPrimaryAccount: false));
                                    }
                                  }
                                },
                                child: const Text('Save'),
                              );
                            },
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  String? _errorMessageGetter(GetBankByIfscState state) {
    if (state is GetBankByIfscFailure) {
      return Utils.getErrorMessage(
          errorType: state.errorType, msg: state.errorMessage);
    }
    return null;
  }
}
