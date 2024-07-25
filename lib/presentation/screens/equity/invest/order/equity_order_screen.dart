import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../domain/entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/equity_orders/equity_orders_cubit.dart';
import '../../../../widgets/app_error_widget.dart';
import 'etf/widgets/etf_order_tile.dart';

import '../../../../../common/common.dart';
import '../../../../../gen/assets.gen.dart';

class EquityOrderScreen extends StatefulWidget {
  const EquityOrderScreen({super.key});

  @override
  State<EquityOrderScreen> createState() => _EquityOrderScreenState();
}

class _EquityOrderScreenState extends State<EquityOrderScreen> {
  String _isSelected = '';

  void _handleButtonSatus(String label) {
    setState(() {
      if (_isSelected.isNotEmpty) {
        _isSelected = '';
      }
      if (_isSelected != label) {
        _isSelected = label;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<EquityOrdersCubit, EquityOrdersState>(
        builder: (context, state) {
          return Column(
            children: [
              const Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _handleButtonSatus('COMPLETE');
                        context.read<EquityOrdersCubit>().fetchOrders(
                            EquityOrdersParams(
                                email: context
                                    .read<AuthCubit>()
                                    .state
                                    .user!
                                    .emailId,
                                timePeriod: 'ONE_MONTH',
                                status: 'COMPLETE'));
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _isSelected == 'COMPLETE'
                                  ? Colors.blue
                                  : Colors.black54),
                          color: _isSelected == 'COMPLETE'
                              ? Colors.blue[50]
                              : null,
                        ),
                        child: Center(
                            child: Text(
                          'completed',
                          style: TextStyle(
                              color: _isSelected == 'COMPLETE'
                                  ? Colors.blue
                                  : Colors.black54,
                              fontSize: 10),
                        )),
                      ),
                    ),
                    const Gap(18),
                    InkWell(
                      onTap: () {
                        _handleButtonSatus('CANCELLED');
                        context.read<EquityOrdersCubit>().fetchOrders(
                            EquityOrdersParams(
                                email: context
                                    .read<AuthCubit>()
                                    .state
                                    .user!
                                    .emailId,
                                timePeriod: 'ONE_MONTH',
                                status: 'CANCELLED'));
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _isSelected == 'CANCELLED'
                                  ? Colors.blue
                                  : Colors.black54),
                          color: _isSelected == 'CANCELLED'
                              ? Colors.blue[50]
                              : null,
                        ),
                        child: Center(
                            child: Text(
                          'Cancelled',
                          style: TextStyle(
                              color: _isSelected == 'CANCELLED'
                                  ? Colors.blue
                                  : Colors.black54,
                              fontSize: 10),
                        )),
                      ),
                    ),
                    const Gap(18),
                    InkWell(
                      onTap: () {
                        _handleButtonSatus('REJECTED');
                        context.read<EquityOrdersCubit>().fetchOrders(
                            EquityOrdersParams(
                                email: context
                                    .read<AuthCubit>()
                                    .state
                                    .user!
                                    .emailId,
                                timePeriod: 'ONE_MONTH',
                                status: 'REJECTED'));
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _isSelected == 'REJECTED'
                                  ? Colors.blue
                                  : Colors.black54),
                          color: _isSelected == 'REJECTED'
                              ? Colors.blue[50]
                              : null,
                        ),
                        child: Center(
                            child: Text(
                          'Rejected',
                          style: TextStyle(
                              color: _isSelected == 'REJECTED'
                                  ? Colors.blue
                                  : Colors.black54,
                              fontSize: 10),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: BlocBuilder<EquityOrdersCubit, EquityOrdersState>(
                  builder: (context, state) {
                    if (state is EquityOrdersLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (state is EquityOrdersFailure) {
                      return AppErrorWidget(
                        errorType: state.errorType,
                        error: state.errorMessage,
                        onRetry: () => context.read<EquityOrdersCubit>()
                          ..fetchOrders(EquityOrdersParams(
                              email:
                                  context.read<AuthCubit>().state.user!.emailId,
                              timePeriod: 'ONE_MONTH',
                              status: '')),
                      );
                    }
                    if (state is EquityOrdersSuccess) {
                      final orders = state.equityOrderModel;
                      if (orders.isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ETFOrderTile(
                                image: orders[index].icon ?? '',
                                title: orders[index].tradingSymbol ?? '',
                                subtitle: orders[index].companyName ?? '',
                                price: orders[index].averagePrice ?? 0.0,
                                qty: orders[index].quantity ?? 0,
                                isSell: orders[index].transactionType ?? '',
                                status: orders[index].status ?? '',
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.pngs.noOrders.image(),
                            const Gap(24),
                            Text(
                              'No pending orders at the moment',
                              style: baseTextStyle2,
                            ),
                          ],
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
