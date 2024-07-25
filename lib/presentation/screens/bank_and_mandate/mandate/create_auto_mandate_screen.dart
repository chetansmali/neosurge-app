import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../flavors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/create_mandate_cubit/create_mandate_cubit.dart';
import '../../../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../../../cubits/account/user_mandate_cubit/user_mandate_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import 'bank_card_widget.dart';

class CreateAutoMandateScreen extends StatefulWidget {
  const CreateAutoMandateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAutoMandateScreen> createState() =>
      _CreateAutoMandateScreenState();
}

class _CreateAutoMandateScreenState extends State<CreateAutoMandateScreen> {
  final _formKey = GlobalKey<FormState>();
  int _limitSelected = 0;
  double _limitAmount = 500000;

  @override
  Widget build(BuildContext context) {
    final UserBank bank = context.watch<UserBankDetailsCubit>().selectedBank;
    return BlocConsumer<CreateMandateCubit, CreateMandateState>(
      listener: (context, state) {
        if (state is CreateMandateSuccess) {
          //If mandate is created successfully update the mandate id in bank object
          context
              .read<UserBankDetailsCubit>()
              .updateBank(bank.copyWith(mandateId: state.mandate.mandateId));
          context.read<UserMandateCubit>().setMandate(state.mandate);
          Navigator.pushReplacementNamed(context, Routes.autoMandateStatus,
              arguments: AutoMandateStatusArgs(
                  bank: bank, mandate: state.mandate, isCreate: true));
        }
        if (state is CreateMandateError) {
          Utils.showErrorAlert(
            context,
            Utils.getErrorMessage(errorType: state.errorType, msg: state.error),
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => state is! CreateMandateLoading,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Bank account details'),
              ),
              body: BlocBuilder<CreateMandateCubit, CreateMandateState>(
                builder: (context, state) {
                  if (state is CreateMandateLoading) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.animations.bankLoading.lottie(
                            height: 200,
                            width: 200,
                          ),
                          const Gap(20),
                          const Text(
                            'Just a Moment!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(20),
                          const Text(
                            'We are creating your mandate...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: BankCardWidget(bank: bank),
                            ),
                            const Gap(16.0),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Specify your limit for Auto-Mandate',
                                      style: baseTextStyle14500.copyWith(
                                          color: AppColors.neutral[900]),
                                    ),
                                    const Gap(8),
                                    Text(
                                      'This is the minimum amount you can invest in one go using Auto-Mandate.',
                                      style: baseTextStyle12400.copyWith(
                                          color: AppColors.neutral[400]),
                                    ),
                                    const Gap(20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Choose Limit',
                                              style:
                                                  baseTextStyle14400.copyWith(
                                                      color: AppColors
                                                          .neutral[600])),
                                          const Gap(8.0),
                                          Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            alignment: WrapAlignment.start,
                                            children: [
                                              _LimitContainer(
                                                title: '₹ 5 lakhs',
                                                onTap: () {
                                                  setState(() {
                                                    _limitSelected = 0;
                                                    _limitAmount = 500000;
                                                  });
                                                },
                                                selected: _limitSelected == 0,
                                              ),
                                              _LimitContainer(
                                                title: '₹ 10 lakhs',
                                                onTap: () {
                                                  setState(() {
                                                    _limitSelected = 1;
                                                    _limitAmount = 1000000;
                                                  });
                                                },
                                                selected: _limitSelected == 1,
                                              ),
                                              _LimitContainer(
                                                title: '₹ 25 lakhs',
                                                onTap: () {
                                                  setState(() {
                                                    _limitSelected = 2;
                                                    _limitAmount = 2500000;
                                                  });
                                                },
                                                selected: _limitSelected == 2,
                                              ),
                                              _LimitContainer(
                                                title: '₹ 50 lakhs',
                                                onTap: () {
                                                  setState(() {
                                                    _limitSelected = 3;
                                                    _limitAmount = 5000000;
                                                  });
                                                },
                                                selected: _limitSelected == 3,
                                              ),
                                              _LimitContainer(
                                                title: '₹ 1 crore',
                                                onTap: () {
                                                  setState(() {
                                                    _limitSelected = 4;
                                                    _limitAmount = 10000000;
                                                  });
                                                },
                                                selected: _limitSelected == 4,
                                              ),
                                              _LimitContainer(
                                                title: 'Custom',
                                                onTap: () {
                                                  setState(() {
                                                    _limitSelected = 5;
                                                  });
                                                },
                                                selected: _limitSelected == 5,
                                              ),
                                            ],
                                          ),
                                          if (_limitSelected == 5) ...[
                                            const Gap(24),
                                            Text(
                                              'Enter Amount',
                                              style:
                                                  baseTextStyle14400.copyWith(
                                                      color: AppColors
                                                          .neutral[600]),
                                            ),
                                            const Gap(8),
                                            TextFormField(
                                              key: const Key('0'),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter amount';
                                                }
                                                double val = double.parse(
                                                    value.replaceAll(',', ''));
                                                if (val < 25000) {
                                                  return 'Minimum amount is \u20B9 25000';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                prefixText: '\u20B9 ',
                                              ),
                                              onSaved: (value) {
                                                _limitAmount = double.parse(
                                                    value!.replaceAll(',', ''));
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                CurrencyTextInputFormatter(
                                                    locale: 'en_IN',
                                                    decimalDigits: 0,
                                                    symbol: ''),
                                              ],
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                            ),
                                          ],
                                          const Gap(20),
                                          Text(
                                            'Frequency',
                                            style: baseTextStyle14400.copyWith(
                                                color: AppColors.neutral[600]),
                                          ),
                                          const Gap(8),
                                          TextFormField(
                                            key: const Key('1'),
                                            readOnly: true,
                                            initialValue:
                                                'As and when presented',
                                          ),
                                          const Gap(20),
                                          Text(
                                            'Auto-Mandate Validity',
                                            style: baseTextStyle14400.copyWith(
                                                color: AppColors.neutral[600]),
                                          ),
                                          const Gap(8),
                                          TextFormField(
                                            key: const Key('2'),
                                            readOnly: true,
                                            initialValue:
                                                'Until cancelled by me',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
              bottomNavigationBar: SafeArea(
                minimum: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            context.read<CreateMandateCubit>().createMandate(
                                limit: _limitAmount, bankId: bank.id);
                          }
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                    const Gap(8.0),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'By confirming, you agree to Neosurge\'s ',
                          style: const TextStyle(
                            color: AppColors.textLightGrey,
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: 'T&C\'s',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.aboutWebView,
                                    arguments: AboutWebViewArgs(
                                      url: F.baseUrl +
                                          ApiConstants.termsAndConditions,
                                      title: 'Terms and Conditions',
                                    ),
                                  );
                                },
                              style: const TextStyle(
                                  color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LimitContainer extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _LimitContainer(
      {Key? key,
      required this.title,
      this.selected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.success[500] : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: AppColors.success[500]!,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: baseTextStyle12500.copyWith(
              color: selected ? Colors.white : AppColors.success[500]),
        ),
      ),
    );
  }
}
