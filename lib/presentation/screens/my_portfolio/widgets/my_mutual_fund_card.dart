import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/mutual_funds/get_fund_by_isin/get_fund_by_isin_cubit.dart';
import '../../../cubits/mutual_funds/mf_sort_by_switch/mf_sort_by_switch_cubit.dart';
import '../../../theme/app_colors.dart';
import 'detailed_fund_bottomsheet.dart';

class MyMutualFundCard extends StatelessWidget {
  final UserMfScheme scheme;

  const MyMutualFundCard({
    Key? key,
    required this.scheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (ctx) => BlocProvider.value(
            value: context.read<GetFundByIsinCubit>()..getFund(isin: scheme.isin),
            child: DetailedFundBottomSheet(
              scheme: scheme,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    scheme.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: BlocBuilder<MfSortBySwitchCubit, MfSortBySwitchState>(
                    builder: (context, state) {
                      return Text(
                        getSortByValues(state.sortBy),
                        textAlign: TextAlign.end,
                      );
                    },
                  ),
                ),
              ],
            ),
            const Gap(4),
            Text(
              'Nav ${scheme.nav}',
              style: const TextStyle(color: AppColors.primaryColor, fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ]),
        ),
      ),
    );
  }

  String getSortByValues(MFSortBy sortBy) {
    switch (sortBy) {
      case MFSortBy.currInvested:
        return '${scheme.currentValue.toCurrencyWithSymbol(decimalDigits: 2)}\n(${scheme.investedAmount.toCurrencyWithSymbol(decimalDigits: 2)})';
      case MFSortBy.currentNav:
        return scheme.nav.toString();
      case MFSortBy.absReturn:
        return scheme.absoluteReturns.toString();
      case MFSortBy.gainLoss:
        return scheme.gainOrLoss.toString();
    }
  }
}
