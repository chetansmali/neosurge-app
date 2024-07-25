import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/user/user.dart';
import '../../../cubits/account/update_primary_bank_cubit/update_primary_bank_cubit.dart';
import '../../../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../../loading_screen.dart';
import 'bank_info_card.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bank Account Details'),
        ),
        body: SafeArea(
          child: BlocListener<UpdatePrimaryBankCubit, UpdatePrimaryBankState>(
            listener: (context, state) {
              if (state is UpdatePrimaryBankSuccess) {
                Utils.showSuccessAlert(
                    context, 'Primary Bank Updated Successfully');
                context
                    .read<UserBankDetailsCubit>()
                    .updatePrimaryBankAccount(state.index);
              }
              if (state is UpdatePrimaryBankError) {
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                      errorType: state.errorType, msg: state.errorMessage),
                );
              }
            },
            child: BlocBuilder<UserBankDetailsCubit, UserBankDetailsState>(
              builder: (context, state) {
                if (state is UserBankDetailsLoading) {
                  return const Center(child: CustomLoader());
                }
                if (state is UserBankDetailsLoadError) {
                  return Center(
                    child: AppErrorWidget(
                        errorType: state.errorType, error: state.errorMessage),
                  );
                }
                if (state is UserBankDetailsLoaded) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.bankList.length + 1,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            if (index < state.bankList.length) {
                              return BankInfoCard(
                                index: index,
                                bank: state.bankList[index],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      if (state.bankList.length < 5)
                        ElevatedButton(
                          onPressed: () {
                            if (!user.eSignSubmitDone &&
                                !user.isOnBoardingCompleted) {
                              Fluttertoast.showToast(
                                  msg: 'Please complete your kyc to add bank');
                              return;
                            } else if (!user.isOnBoardingCompleted) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Your kyc is under review. Once approved, you will be able to add bank');
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              Routes.addProfileBankDetails,
                            );
                          },
                          child: const Text('Add Bank Account'),
                        ),
                      const Gap(20),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
