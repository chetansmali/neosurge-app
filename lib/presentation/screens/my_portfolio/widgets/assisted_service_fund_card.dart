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

class AssistedServiceFundCard extends StatefulWidget {
  final UserMfScheme scheme;
  final int? delay;
  final bool isCurrentlyAssistedUser;

  const AssistedServiceFundCard({
    Key? key,
    required this.scheme,
    this.delay,
    required this.isCurrentlyAssistedUser,
  }) : super(key: key);

  @override
  State<AssistedServiceFundCard> createState() => _AssistedServiceFundCardState();
}

class _AssistedServiceFundCardState extends State<AssistedServiceFundCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<Color?> _animColor;
  late final Animation<Color?> _textColor;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animColor = ColorTween(begin: Colors.white, end: AppColors.lightRed).animate(_animController);
    _textColor = ColorTween(begin: Colors.black, end: Colors.white).animate(_animController);
    _animController.addStatusListener((status) async {
      if (_isDisposed) return;
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(seconds: 2));
        _animController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        await Future.delayed(const Duration(seconds: 2));
        _animController.forward();
      }
      setState(() {});
    });
    if (widget.scheme.exitTriggerGenerated && widget.isCurrentlyAssistedUser) {
      _animController.forward();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) => Card(
        margin: const EdgeInsets.symmetric(vertical: 1),
        color: _animColor.value,
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
                    value: context.read<GetFundByIsinCubit>()..getFund(isin: widget.scheme.isin),
                    child: DetailedFundBottomSheet(
                      scheme: widget.scheme,
                    ),
                  )),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.scheme.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _textColor.value,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: BlocBuilder<MfSortBySwitchCubit, MfSortBySwitchState>(
                      builder: (context, state) {
                        return Text(
                          getSortByValues(state.sortBy),
                          textAlign: TextAlign.end,
                          style: TextStyle(color: _textColor.value),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Gap(4),
              Text(
                'Nav ${widget.scheme.nav}',
                style: const TextStyle(color: AppColors.primaryColor, fontSize: 10, fontWeight: FontWeight.w600),
              ),
              if (widget.scheme.exitTriggerGenerated && widget.isCurrentlyAssistedUser) ...[
                const Gap(4),
                Center(
                  child: Text(
                    'Exit from this Scheme',
                    style: TextStyle(
                      fontSize: 10,
                      color: _textColor.value,
                    ),
                  ),
                ),
              ],
            ]),
          ),
        ),
      ),
    );
  }

  String getSortByValues(MFSortBy sortBy) {
    switch (sortBy) {
      case MFSortBy.currInvested:
        return '${widget.scheme.currentValue.toCurrencyWithSymbol()}\n(${widget.scheme.investedAmount.toCurrencyWithSymbol()})';
      case MFSortBy.currentNav:
        return widget.scheme.nav.toString();
      case MFSortBy.absReturn:
        return widget.scheme.absoluteReturns.toString();
      case MFSortBy.gainLoss:
        return widget.scheme.gainOrLoss.toString();
    }
  }
}
