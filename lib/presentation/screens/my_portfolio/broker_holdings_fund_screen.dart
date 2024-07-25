import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/api/api_constants.dart';
import 'widgets/investment_card.dart';

import '../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/import_external_fund/broker_holdings_fund/broker_holdings_fund_cubit.dart';
import '../../widgets/app_error_widget.dart';
import 'widgets/scheme_holding_card.dart';

class BrokerHoldingsFundScreen extends StatelessWidget {
  const BrokerHoldingsFundScreen({
    super.key,
    required this.brokerName,
    required this.currentAssetValue,
    required this.investedValue,
    required this.returnValue,
  });

  final String brokerName;
  final double? currentAssetValue;
  final double? investedValue;
  final double? returnValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brokerName),
      ),
      body: SafeArea(
        child: BlocBuilder<BrokerHoldingsFundCubit, BrokerHoldingsFundState>(
          builder: (context, state) {
            if (state is BrokerHoldingsFundLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is BrokerHoldingsFundLoadError) {
              return Center(
                child: AppErrorWidget(
                  errorType: state.appErrorType,
                  error: state.errorMessage,
                  onRetry: () => context
                      .read<BrokerHoldingsFundCubit>()
                      .getBrokerHoldingsFund(
                        userId: context.read<AuthCubit>().state.user!.id,
                        brokerName: brokerName,
                      ),
                ),
              );
            }

            if (state is BrokerHoldingsFundLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: InvestmentCard(
                        user: ImportedHoldingUser(
                          currentAssetValue: currentAssetValue ?? 0,
                          investedValue: investedValue ?? 0,
                          returnValue: returnValue ?? 0,
                          returnPercentage: returnValue != null &&
                                  currentAssetValue != null &&
                                  currentAssetValue != 0
                              ? (returnValue! * 100) / investedValue!
                              : 0,
                        ),
                        animatedCard: false,
                        isRefreshButtonVisible: false,
                      ),
                    ),
                    const Gap(24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Funds',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Gap(24),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.brokerHoldingsFunds.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      itemBuilder: (context, index) {
                        return ShchemeHoldingCard(
                          folioNumber:
                              state.brokerHoldingsFunds[index].folioNumber ??
                                  '',
                          image:
                              '${ApiConstants.baseProdUrl}/${state.brokerHoldingsFunds[index].amcLogo}',
                          schemeName:
                              state.brokerHoldingsFunds[index].schemeName ?? '',
                          currentValue:
                              state.brokerHoldingsFunds[index].currentValue ??
                                  0,
                          investedValue:
                              state.brokerHoldingsFunds[index].investedValue ??
                                  0,
                          returnValue:
                              state.brokerHoldingsFunds[index].currentReturns ??
                                  0,
                          returnPercentage: state.brokerHoldingsFunds[index]
                                  .returnsPercentage ??
                              0,
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
