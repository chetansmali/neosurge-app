import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../cubits/account/update_bank_ifsc_cubit/update_bank_ifsc_cubit.dart';
import '../../../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../../../cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/label_text.dart';
import '../../loading_screen.dart';

class EditBankIfscScreen extends StatelessWidget {
  final int index;
  final UserBank bank;

  const EditBankIfscScreen({Key? key, required this.bank, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Bank IFSC'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const LabelText(label: 'Enter IFSC Code'),
                      BlocBuilder<GetBankByIfscCubit, GetBankByIfscState>(
                        builder: (context, state) {
                          return TextFormField(
                            maxLength: 11,
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.characters,
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
                                const Gap(30),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const Spacer(),
                      const Gap(20),
                      BlocListener<UpdateBankIfscCubit, UpdateBankIfscState>(
                        listener: (context, state) {
                          if (state is UpdateBankIfscSuccess) {
                            context
                                .read<UserBankDetailsCubit>()
                                .updateBank(state.bank);
                            Utils.showSuccessAlert(
                                context, 'Bank IFSC updated successfully');
                            Navigator.pop(context);
                          }
                          if (state is UpdateBankIfscFailure) {
                            Utils.showErrorAlert(
                              context,
                              Utils.getErrorMessage(
                                  errorType: state.errorType, msg: state.error),
                            );
                          }
                        },
                        child:
                            BlocBuilder<GetBankByIfscCubit, GetBankByIfscState>(
                          builder: (context, state) {
                            return ElevatedButton(
                                onPressed: state is GetBankByIfscSuccess
                                    ? () {
                                        if (bank.ifscCode ==
                                            state.bank.ifscCode) {
                                          Utils.showWarningAlert(context,
                                              'IFSC Code is same as previous one');
                                          return;
                                        }

                                        if (bank.ifscCode.substring(0, 4) !=
                                            state.bank.ifscCode
                                                .substring(0, 4)) {
                                          Utils.showWarningAlert(context,
                                              'IFSC should be of same bank');
                                          return;
                                        }
                                        context
                                            .read<UpdateBankIfscCubit>()
                                            .updateBankIfsc(bank.copyWith(
                                                ifscCode: state.bank.ifscCode,
                                                branchName:
                                                    state.bank.branchName));
                                      }
                                    : null,
                                child: const Text('Confirm'));
                          },
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                )
              ],
            ),
          )),
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
