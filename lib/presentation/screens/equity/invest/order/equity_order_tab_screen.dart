import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/equity_orders/equity_orders_cubit.dart';
import '../../../../theme/app_colors.dart';
import 'equity_order_screen.dart';
import 'etf/etf_order_screen.dart';

import '../../../../../common/common.dart';

class EquityOrderTabScreen extends StatefulWidget {
  const EquityOrderTabScreen({super.key});

  @override
  State<EquityOrderTabScreen> createState() => _EquityOrderTabScreenState();
}

class _EquityOrderTabScreenState extends State<EquityOrderTabScreen> {
  @override
  Widget build(BuildContext context) {
    final String email = context.read<AuthCubit>().state.user!.emailId;

    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: AppColors.primaryColor,
                  labelStyle: baseTextStyle14500,
                  labelColor: AppColors.neutral[900],
                  unselectedLabelColor: AppColors.neutral[400],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 4.0,
                  dividerHeight: 0.0,
                  tabs: const [
                    Tab(text: 'Equity'),
                    Tab(text: 'ETF'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocProvider(
                        create: (context) => getIt<EquityOrdersCubit>()
                          ..fetchOrders(EquityOrdersParams(
                              email: email,
                              timePeriod: 'ONE_MONTH',
                              status: '')),
                        child: const EquityOrderScreen(),
                      ),
                      BlocProvider(
                        create: (context) => getIt<EquityOrdersCubit>()
                          ..fetchETFOrders(EquityOrdersParams(
                              email: email,
                              timePeriod: 'ONE_MONTH',
                              status: '',
                              instrumentType: 'ETF')),
                        child: const ETFOrderScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
