import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../di/get_it.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/assisted_service/get_suggested_funds_cubit/get_suggested_funds_cubit.dart';
import '../../../cubits/assisted_service/invest_suggested_funds_cubit/invest_suggested_funds_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/create_consent/create_consent_cubit.dart';
import '../../../cubits/mutual_funds/lumpsum_purchase/create_lumpsum_purchase_cubit.dart';
import '../../../cubits/mutual_funds/sip_order/sip_order_cubit.dart';
import '../../../cubits/mutual_funds/verify_consent/verify_consent_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/auto_widget_switcher.dart';
import '../../../widgets/empty_portfolio_view.dart';
import '../../loading_screen.dart';
import '../consent_otp_screen.dart';
import 'widget/fund_suggestion_chart.dart';
import 'widget/fund_suggestion_list.dart';

class FundSuggestionScreen extends StatelessWidget {
  final double amount;
  final int tenure;

  const FundSuggestionScreen(
      {Key? key, required this.amount, required this.tenure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void getSuggestedFunds() =>
        context.read<GetSuggestedFundsCubit>().getSuggestedFunds(
            amount: amount,
            tenure: tenure,
            userId: context.read<AuthCubit>().state.user!.id);
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Suggested Fund Allocations'),
        ),
        body: BlocBuilder<GetSuggestedFundsCubit, GetSuggestedFundsState>(
          builder: (context, state) {
            if (state is GetSuggestedFundsLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: AutoWidgetSwitcher(children: [
                        Assets.svgs.assistedServiceLoading0
                            .svg(key: const ValueKey(0)),
                        Assets.svgs.assistedServiceLoading1
                            .svg(key: const ValueKey(1)),
                        Assets.svgs.assistedServiceLoading2
                            .svg(key: const ValueKey(2)),
                      ]),
                    ),
                    Text('Almost there!!',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Gap(5),
                    Text('We are cooking the best strategy for you',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              );
            }
            if (state is GetSuggestedFundsError) {
              return Center(
                child: AppErrorWidget(
                    errorType: state.appErrorType,
                    error: state.error,
                    onRetry: getSuggestedFunds),
              );
            }
            if (state is GetSuggestedFundsLoaded) {
              if (state.funds.isEmpty) {
                return const Center(
                  child: EmptyPortfolioView(
                      message: 'No funds found for your profile'),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 430,
                              child: FundSuggestionList(funds: state.funds),
                            ),
                            const Gap(10),
                            FundSuggestionChart(
                              funds: state.funds,
                              totalAmount: amount,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          blurStyle: BlurStyle.outer,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: getSuggestedFunds,
                            child: const Text('OTHER SUGGESTION'),
                          ),
                        ),
                        const Gap(10),
                        MultiBlocListener(
                          listeners: [
                            BlocListener<CreateConsentCubit,
                                    CreateConsentState>(
                                listener: (_, consentstate) {
                              if (consentstate is CreateConsentSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => getIt<
                                              CreateLumpsumPurchaseCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<SipOrderCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<VerifyConsentCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<CreateConsentCubit>(),
                                        ),
                                        BlocProvider(
                                          create: (context) => getIt<
                                              InvestSuggestedFundsCubit>(),
                                        ),
                                      ],
                                      child: ConsentOtpScreen(
                                        mobileNumber: consentstate
                                            .createConsentModel.mobile,
                                        consentId:
                                            consentstate.createConsentModel.id,
                                        isSip: false,
                                        isAssistedService: true,
                                        suggestedFunds: state.funds,
                                        fundAmount: amount,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (consentstate is CreateConsentFailed) {
                                Utils.showErrorAlert(
                                    context, consentstate.message);
                              }
                            }),
                          ],
                          child: Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                String mobilenumber = context
                                        .read<AuthCubit>()
                                        .state
                                        .user!
                                        .mobileNumber ??
                                    '';
                                if (mobilenumber.isNotEmpty) {
                                  context
                                      .read<CreateConsentCubit>()
                                      .createLumpsumConsent();
                                } else {
                                  Utils.showErrorAlert(
                                      context, 'Mobile number not found!');
                                }
                              },
                              child: const Text('INVEST'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
