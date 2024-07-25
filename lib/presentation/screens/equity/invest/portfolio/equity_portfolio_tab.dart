import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/params/equity/equity_portfolio/get_smallcase_funds.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/portfolio_holdings_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/portfolio_positions_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/smallcase_funds_cubit.dart';
import '../../../../theme/app_colors.dart';
import 'equity_portfolio_screen.dart';
import 'etf/etf_portfolio_screen.dart';

class EquityPortfolioTabScreen extends StatefulWidget {
  const EquityPortfolioTabScreen({super.key});

  @override
  State<EquityPortfolioTabScreen> createState() =>
      _EquityPortfolioTabScreenState();
}

class _EquityPortfolioTabScreenState extends State<EquityPortfolioTabScreen> {
  bool isEtfSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isEtfSelected = false),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: isEtfSelected
                        ? Border.all(color: AppColors.neutral[200]!)
                        : null,
                    color: !isEtfSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Equity',
                    style: baseTextStyle12500.copyWith(
                        color: !isEtfSelected
                            ? Colors.white
                            : AppColors.neutral[700]),
                  ),
                ),
              ),
              const Gap(12),
              GestureDetector(
                onTap: () => setState(() => isEtfSelected = true),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: !isEtfSelected
                        ? Border.all(color: AppColors.neutral[200]!)
                        : null,
                    color: isEtfSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  margin: const EdgeInsets.all(4),
                  child: Text(
                    'ETF',
                    style: baseTextStyle12500.copyWith(
                        color: isEtfSelected
                            ? Colors.white
                            : AppColors.neutral[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        Expanded(
          child: isEtfSelected
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          getIt<PortfolioPositionsCubit>()..fetchETFPositions(),
                    ),
                    BlocProvider(
                      create: (context) =>
                          getIt<PortfolioHoldingsCubit>()..fetchETFHoldings(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<SmallcaseFundsCubit>()
                        ..fetchSmallcasefunds(
                          GetFundasParams(
                            email:
                                context.read<AuthCubit>().state.user!.emailId,
                          ),
                        ),
                    ),
                  ],
                  child: const ETFPortfolioScreen(),
                )
              : MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          getIt<PortfolioHoldingsCubit>()..fetchHoldings(),
                    ),
                    BlocProvider(
                      create: (context) =>
                          getIt<PortfolioPositionsCubit>()..fetchPositions(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<SmallcaseFundsCubit>()
                        ..fetchSmallcasefunds(
                          GetFundasParams(
                            email:
                                context.read<AuthCubit>().state.user!.emailId,
                          ),
                        ),
                    ),
                  ],
                  child: const PortfolioScreen(),
                ),
        ),
      ],
    );
  }
}
