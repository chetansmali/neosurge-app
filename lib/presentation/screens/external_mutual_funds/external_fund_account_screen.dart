import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/params/import_external_fund/validate_transaction_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/import_external_fund/account_details/account_details_cubit.dart';
import '../../cubits/import_external_fund/transaction/transaction_cubit.dart';
import '../../routes/routes.dart';

import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../loading_screen.dart';

class ImportExternalFundsAccountScreen extends StatefulWidget {
  const ImportExternalFundsAccountScreen({super.key});

  @override
  State<ImportExternalFundsAccountScreen> createState() =>
      _ImportExternalFundsAccountScreenState();
}

class _ImportExternalFundsAccountScreenState
    extends State<ImportExternalFundsAccountScreen> {
  final TextEditingController _panController = TextEditingController();
  final _mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _mobileFieldFocusNode = FocusNode();
  bool _isPanInitiallyInvalid = false;
  bool _isMobileNumberFieldEnabled = false;

  @override
  void initState() {
    _panController.addListener(_validateForm);
    _mobileController.addListener(_validateForm);
    super.initState();
  }

  @override
  void dispose() {
    _panController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Import Mutual Funds'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Builder(
          builder: (context) {
            var btnState = context.watch<AccountDetailsCubit>().state;

            return SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onPressed(state: btnState),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        214,
                        50,
                      ),
                      maximumSize: const Size(
                        214,
                        50,
                      ),
                    ),
                    child: const Text('Import'),
                  ),
                ],
              ),
            );
          },
        ),
        body: BlocConsumer<AccountDetailsCubit, AccountDetailsState>(
          listener: (BuildContext context, state) {
            if (state is AccountDetailsLoaded) {
              _mobileController.text = state.accountDetailsResponse.phoneNumber;
              _panController.text = state.accountDetailsResponse.panNumber;
              _isPanInitiallyInvalid = _panController.text.isEmpty;
              context.read<AccountDetailsCubit>().validateForm(
                    panNumber: _panController.text,
                    mobileNumber: _mobileController.text,
                  );
            }
          },
          buildWhen: (previous, current) => current is! AccountDetailsChanged,
          builder: (context, state) {
            if (state is AccountDetailsLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (state is AccountDetailsLoadError) {
              // In case the user has no MF holdings in his account
              if (state.errorMessage != null &&
                  state.errorMessage!.contains('No entity found for query')) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.svgs.equityNoOrder.svg(),
                      const Gap(8.0),
                      const Text('No mutual fund holdings found'),
                    ],
                  ),
                );
              }

              return Center(
                child: AppErrorWidget(
                  errorType: state.appErrorType,
                  error: state.errorMessage,
                ),
              );
            }

            if (state is AccountDetailsLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Gap(22),
                        const Text(
                          'PAN',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        const Gap(8),
                        TextFormField(
                          controller: _panController,
                          decoration: const InputDecoration(
                            counterText: '',
                          ),
                          enabled: _isPanInitiallyInvalid,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            /// Make all characters uppercase only
                            ConvertToUpperCaseFormatter(),
                          ],
                          maxLength: 10,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppColors.mainBlack,
                          ),
                        ),
                        const Gap(16),
                        const Text(
                          'Mobile Number',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        const Gap(4),
                        const Text(
                          'Enter mobile number that is linked to any of your holdings',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: AppColors.textGrey,
                          ),
                        ),
                        const Gap(8),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              controller: _mobileController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              readOnly: _isMobileNumberFieldEnabled == false,
                              focusNode: _mobileFieldFocusNode,
                              decoration: const InputDecoration(
                                counterText: '',
                                prefixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '+91',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.mainBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: AppColors.mainBlack,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _isMobileNumberFieldEnabled
                                    ? Icons.check
                                    : Icons.edit_outlined,
                                color: AppColors.primaryColor,
                              ),
                              onPressed: () {
                                _isMobileNumberFieldEnabled =
                                    !_isMobileNumberFieldEnabled;

                                _isMobileNumberFieldEnabled
                                    ? _mobileFieldFocusNode.requestFocus()
                                    : _mobileFieldFocusNode.unfocus();

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  VoidCallback? onPressed({required AccountDetailsState state}) {
    if (state is AccountDetailsChanged) {
      if (state.isBtnEnabled) {
        return () async {
          await context.read<TransactionCubit>().initailiseImportTransaction(
                userId: context.read<AuthCubit>().state.user!.id,
                panNumber: _panController.text,
                phoneNumber: _mobileController.text,
              );

          if (context.mounted) {
            var state = context.read<TransactionCubit>().state;

            if (state is TransactionError) {
              Utils.showErrorAlert(
                context,
                Utils.getErrorMessage(
                  errorType: state.appErrorType,
                  msg: state.errorMessage,
                ),
              );
            }

            if (state is TransactionInitialised) {
              Navigator.pushNamed(
                context,
                Routes.importExternalFundsVerifyOtp,
                arguments: ValidateTransactionParams(
                  userID: context.read<AuthCubit>().state.user!.id,
                  panNumber: _panController.text,
                  phoneNumber: _mobileController.text,
                  transactionID:
                      state.initialiseTransactionReposnse.transactionID,
                ),
              );
            }
          }
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  void _validateForm() {
    context.read<AccountDetailsCubit>().validateForm(
          panNumber: _panController.text,
          mobileNumber: _mobileController.text,
        );
  }
}

class ConvertToUpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
