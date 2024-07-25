import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../logger.dart';
import '../../../cubits/mutual_funds/get_fund_by_isin/get_fund_by_isin_cubit.dart';
import '../../../cubits/util_cubits/nav_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';

const double _kButtonHeight = 42;

class DetailedFundBottomSheet extends StatelessWidget {
  final UserMfScheme scheme;

  const DetailedFundBottomSheet({
    Key? key,
    required this.scheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 5,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: AppColors.textGreySilver),
          ),
          const Gap(20),
          Text(
            scheme.currentValue.toCurrencyWithSymbol(decimalDigits: 2),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: TwoRowText(
                    title: 'Invested',
                    subtitle: scheme.investedAmount
                        .toCurrencyWithSymbol(decimalDigits: 2)),
              ),
              const Gap(20),
              Expanded(
                child: TwoRowText(
                  title: 'Units',
                  subtitle: scheme.holdingUnits.toString(),
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: TwoRowText(
                  title: 'Gain/Loss',
                  subtitle:
                      scheme.gainOrLoss.toCurrencyWithSymbol(decimalDigits: 2),
                  subtitleStyle: TextStyle(
                    color: scheme.gainOrLoss >= 0
                        ? AppColors.green
                        : AppColors.textRed,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: TwoRowText(
                  title: 'Abs Returns',
                  subtitle: '${scheme.absoluteReturns.toStringAsFixed(2)} %',
                  subtitleStyle: TextStyle(
                      color: scheme.absoluteReturns > 0
                          ? AppColors.green
                          : AppColors.textRed),
                ),
              ),
            ],
          ),
          const Gap(25),
          Row(
            children: [
              Expanded(
                child: Text(scheme.name, style: const TextStyle(fontSize: 11)),
              ),
              const Gap(10),
              Text('Nav ${scheme.nav}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const Gap(20),
          const Divider(
            thickness: 2,
          ),
          const Gap(20),
          BlocBuilder<GetFundByIsinCubit, GetFundByIsinState>(
            builder: (context, state) {
              if (state is GetFundByIsinLoading) {
                return CustomShimmer(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: _kButtonHeight,
                                child: OutlinedButton(
                                  onPressed: null,
                                  child: Text('REDEEM'),
                                ),
                              )),
                              Gap(20),
                              Expanded(
                                child: SizedBox(
                                  height: _kButtonHeight,
                                  child: ElevatedButton(
                                    onPressed: null,
                                    child: Text('INVEST MORE'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          if (!scheme.isAssistedFund) ...[
                            const SizedBox(
                              width: double.maxFinite,
                              height: _kButtonHeight,
                              child: OutlinedButton(
                                onPressed: null,
                                child: Text('START SWP'),
                              ),
                            ),
                            const Gap(20),
                            const SizedBox(
                              width: double.maxFinite,
                              height: _kButtonHeight,
                              child: OutlinedButton(
                                onPressed: null,
                                child: Text('START STP'),
                              ),
                            ),
                            const Gap(20),
                          ],
                          const SizedBox(
                            width: double.maxFinite,
                            height: _kButtonHeight,
                            child: OutlinedButton(
                              onPressed: null,
                              child: Text('SWITCH'),
                            ),
                          ),
                          const Gap(20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: null,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Assets.icons.menu
                                        .svg(height: 12, width: 12),
                                    const Gap(5),
                                    const Text(
                                      'Fund Transactions',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              if (state is GetFundByIsinLoadFailure) {
                return AppErrorWidget(
                    errorType: state.errorType, error: state.error);
              }
              if (state is GetFundByIsinLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                          height: _kButtonHeight,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.redeem,
                                  arguments: FundTransactionArgs(
                                      scheme: scheme, fund: state.fund));
                            },
                            child: const Text('REDEEM'),
                          ),
                        )),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            height: _kButtonHeight,
                            child: ElevatedButton(
                              onPressed: () {
                                if (scheme.isAssistedFund) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.mutualFunds,
                                    (route) => route.isFirst,
                                  );
                                  final navTabEntity = context
                                      .read<NavCubit>()
                                      .state
                                      .navTabEntity;
                                  context.read<NavCubit>().changeTab(
                                        navTabEntity.copyWith(
                                          mainTabIndex: 3,
                                          mutualFundTabIndex: 1,
                                        ),
                                      );

                                  return;
                                }
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.detailedFundView,
                                  arguments: DetailedFundViewArgs(
                                    schemeCode: state.fund.schemeCode,
                                  ),
                                );
                              },
                              child: const Text('INVEST MORE'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!scheme.isAssistedFund) ...[
                      const Gap(20),
                      SizedBox(
                        width: double.maxFinite,
                        height: _kButtonHeight,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            Routes.swpFund,
                            arguments: SwpFundArgs(
                              scheme: scheme,
                              fund: state.fund,
                            ),
                          ),
                          child: const Text('START SWP'),
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: double.maxFinite,
                        height: _kButtonHeight,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            Routes.stpFundList,
                            arguments: FundTransactionArgs(
                              scheme: scheme,
                              fund: state.fund,
                            ),
                          ),
                          child: const Text('START STP'),
                        ),
                      ),
                    ],
                    if (state.fund.switchAllowed == 'Y') ...[
                      const Gap(20),
                      SizedBox(
                        width: double.maxFinite,
                        height: _kButtonHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.switchFundList,
                              arguments: FundTransactionArgs(
                                scheme: scheme,
                                fund: state.fund,
                              ),
                            );
                          },
                          child: const Text('SWITCH'),
                        ),
                      ),
                    ],
                    const Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primary[50],
                          foregroundColor: AppColors.primary[500],
                        ),
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          Routes.fundTransactions,
                          arguments: FundTransactionArgs(
                            scheme: scheme,
                            fund: state.fund,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Fund Transactions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
