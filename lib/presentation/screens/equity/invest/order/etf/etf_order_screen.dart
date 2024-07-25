import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../domain/entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../../cubits/equity/equity_orders/equity_orders_cubit.dart';
import '../../../../../widgets/widgets.dart';
import 'widgets/etf_order_tile.dart';

class ETFOrderScreen extends StatefulWidget {
  const ETFOrderScreen({super.key});

  @override
  State<ETFOrderScreen> createState() => _ETFOrderScreenState();
}

class _ETFOrderScreenState extends State<ETFOrderScreen> {
  String _isSelected = '';

  void _handleButtonSatus(String label) {
    setState(() {
      if (_isSelected != label) {
        _isSelected = label;
      } else {
        _isSelected = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Gap(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _handleButtonSatus('COMPLETE');
                    context
                        .read<EquityOrdersCubit>()
                        .fetchETFOrders(EquityOrdersParams(
                          email: context.read<AuthCubit>().state.user!.emailId,
                          timePeriod: 'ONE_MONTH',
                          status: _isSelected,
                          instrumentType: 'ETF',
                        ));
                  },
                  splashColor: Colors.transparent,
                  child: Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _isSelected == 'COMPLETE'
                              ? Colors.blue
                              : Colors.black54,
                          width: _isSelected == 'COMPLETE' ? 1.5 : 1.0),
                      color: _isSelected == 'COMPLETE' ? Colors.blue[50] : null,
                    ),
                    child: Center(
                        child: Text(
                      'Completed',
                      style: baseTextStyle10400.copyWith(
                          color: _isSelected == 'COMPLETE'
                              ? Colors.blue
                              : Colors.black54),
                    )),
                  ),
                ),
                const Gap(18),
                InkWell(
                  onTap: () {
                    _handleButtonSatus('CANCELLED');
                    context
                        .read<EquityOrdersCubit>()
                        .fetchOrders(EquityOrdersParams(
                          email: context.read<AuthCubit>().state.user!.emailId,
                          timePeriod: 'ONE_MONTH',
                          status: _isSelected,
                          instrumentType: 'ETF',
                        ));
                  },
                  splashColor: Colors.transparent,
                  child: Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _isSelected == 'CANCELLED'
                              ? Colors.blue
                              : Colors.black54,
                          width: _isSelected == 'CANCELLED' ? 1.5 : 1.0),
                      color:
                          _isSelected == 'CANCELLED' ? Colors.blue[50] : null,
                    ),
                    child: Center(
                        child: Text(
                      'Cancelled',
                      style: baseTextStyle10400.copyWith(
                          color: _isSelected == 'CANCELLED'
                              ? Colors.blue
                              : Colors.black54),
                    )),
                  ),
                ),
                const Gap(18),
                InkWell(
                  onTap: () {
                    _handleButtonSatus('REJECTED');
                    context
                        .read<EquityOrdersCubit>()
                        .fetchOrders(EquityOrdersParams(
                          email: context.read<AuthCubit>().state.user!.emailId,
                          timePeriod: 'ONE_MONTH',
                          status: _isSelected,
                          instrumentType: 'ETF',
                        ));
                  },
                  splashColor: Colors.transparent,
                  child: Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _isSelected == 'REJECTED'
                              ? Colors.blue
                              : Colors.black54,
                          width: _isSelected == 'REJECTED' ? 1.5 : 1.0),
                      color: _isSelected == 'REJECTED' ? Colors.blue[50] : null,
                    ),
                    child: Center(
                        child: Text(
                      'Rejected',
                      style: baseTextStyle10400.copyWith(
                          color: _isSelected == 'REJECTED'
                              ? Colors.blue
                              : Colors.black54),
                    )),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
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
                        email: context.read<AuthCubit>().state.user!.emailId,
                        timePeriod: 'ONE_MONTH',
                        status: '',
                        instrumentType: 'ETF',
                      )),
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
                        return Column(
                          children: [
                            ETFOrderTile(
                              image: orders[index].icon ?? '',
                              title: orders[index].tradingSymbol ?? '',
                              subtitle: orders[index].companyName ?? '',
                              price: orders[index].averagePrice ?? 0.0,
                              qty: orders[index].quantity ?? 0,
                              isSell: orders[index].transactionType ?? '',
                              status: orders[index].status ?? '',
                            ),
                            const Gap(12),
                          ],
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
      ),
    );
  }
}
