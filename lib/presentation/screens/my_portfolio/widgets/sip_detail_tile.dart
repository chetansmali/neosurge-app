import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/custom_styles.dart';
import '../../../../di/get_it.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/delete_sip/delete_sip_cubit.dart';
import '../../../widgets/amount_widget.dart';
import '../../mutual_funds/widgets/basket_custom_container.dart';
import 'delete_basket_sip_confirmation_dialog.dart';

class SipDetailsTile extends StatelessWidget {
  const SipDetailsTile({
    Key? key,
    required this.sipOrderRef,
    required this.amount,
    required this.basketInvestmentDate,
    required this.sipEndDate,
  }) : super(key: key);

  final String sipOrderRef;
  final double amount;
  final int basketInvestmentDate;
  final String sipEndDate;

  void _showDeleteConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
          create: (context) => getIt<DeleteSipCubit>(),
          child: DeleteConfirmationSIPDialog(
            sipOrderRef: sipOrderRef,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasketCustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current SIP Details',
                style: baseTextStyle.copyWith(color: const Color(0xFF050C1B)),
              ),
              GestureDetector(
                onTap: () {
                  _showDeleteConfirmationDialog(context);
                },
                child: Image.asset(
                  Assets.icons.deleteNewIcon.path.toString(),
                  height: 24,
                  width: 24,
                  color: const Color(0xFFCC3A3A),
                ),
              )
            ],
          ),
          const Divider(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly SIP Amount',
                    style:
                        baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
                  ),
                  AmountWidget(
                    amount: amount,
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Investment Date',
                    style:
                        baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
                  ),
                  Text(
                    basketInvestmentDate == 1
                        ? '1st of every month'
                        : basketInvestmentDate == 2
                            ? '2nd of every month'
                            : basketInvestmentDate == 3
                                ? '3rd of every month'
                                : '${basketInvestmentDate}th of every month',
                    style: baseTextStyle1.copyWith(
                      color: const Color(0xFF1D242D),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SIP End Date',
                    style:
                        baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
                  ),
                  Text(
                    sipEndDate,
                    style:
                        baseTextStyle1.copyWith(color: const Color(0xFF1D242D)),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming SIP',
                    style:
                        baseTextStyle1.copyWith(color: const Color(0xFF47586E)),
                  ),
                  Row(
                    children: [
                      Text(
                        basketInvestmentDate > DateTime.now().day
                            ? '$basketInvestmentDate ${DateFormat('MMM').format(
                                  DateTime.now(),
                                ).toUpperCase()}'
                            : '$basketInvestmentDate ${DateFormat('MMM').format(
                                  DateTime.now().add(
                                    const Duration(days: 30),
                                  ),
                                ).toUpperCase()} ',
                        style: baseTextStyle1.copyWith(
                            color: const Color(0xFF1D242D)),
                      ),
                      Text(
                        '(in ${basketInvestmentDate > DateTime.now().day ? DateTime.now().difference(
                              DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                basketInvestmentDate,
                              ),
                            ).inDays.abs() : DateTime(
                            DateTime.now().year,
                            DateTime.now().month + 1,
                            basketInvestmentDate,
                          ).difference(DateTime.now()).inDays} days)',
                        style: baseTextStyle10400.copyWith(
                          color: const Color(0xFFB0B0B0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
