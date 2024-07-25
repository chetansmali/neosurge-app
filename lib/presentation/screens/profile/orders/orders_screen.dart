import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/common.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/equity/equity_orders/equity_orders_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../equity/invest/order/equity_order_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OrderCard(
                title: 'Mutual Funds',
                subtitle: 'Track all your orders history for mutual funds.',
                onClick: () {
                  Navigator.pushNamed(context, Routes.mFOrdersScreen);
                },
              ),
              OrderCard(
                title: 'NeoBaskets',
                subtitle: 'Track all your orders history for NeoBaskets.',
                onClick: () {
                  Navigator.pushNamed(context, Routes.neoBasketOrders);
                },
              ),
              // OrderCard(
              //   title: 'Assisted Services',
              //   subtitle:
              //       'Track all your orders history for Assisted Services  ',
              //   onClick: () {
              //     Fluttertoast.showToast(msg: 'Coming Soon');
              //   },
              // ),
              OrderCard(
                title: 'Digital Gold',
                subtitle:
                    'Track all your orders history for digital gold/silver.',
                onClick: () {
                  Navigator.pushNamed(context, Routes.goldOrdersScreen);
                },
              ),
              OrderCard(
                title: 'Equity',
                subtitle: 'Track all your orders history for Equity.',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => getIt<EquityOrdersCubit>()
                          ..fetchOrders(EquityOrdersParams(
                              email:
                                  context.read<AuthCubit>().state.user!.emailId,
                              timePeriod: 'ONE_MONTH',
                              status: '')),
                        child: Scaffold(
                            appBar: AppBar(
                                title: Text(
                                  'Equity Orders',
                                  style: baseTextStyle14400.copyWith(
                                      color: AppColors.mainBlack),
                                ),
                                centerTitle: true),
                            body: const EquityOrderScreen()),
                      ),
                    ),
                  );
                },
              ),
              // OrderCard(
              //   title: 'ETFs',
              //   subtitle: 'Track all your orders history for ETFs.',
              //   onClick: () {
              //     Fluttertoast.showToast(msg: 'Coming Soon');
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onClick;
  const OrderCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkGrey.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                title,
                style: baseTextStyle14500.copyWith(color: AppColors.mainBlack),
              ),
              subtitle: Text(
                subtitle,
                style: baseTextStyle10400.copyWith(color: AppColors.textGrey),
              ),
              trailing: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.mainBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
