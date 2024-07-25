import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/params/neobaskets/neobaskets_discovery_params.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/neobaskets/neobaskets_discovery/neobasket_discovery_cubit.dart';
import '../../../theme/app_colors.dart';

class BasketSortBottomSheet extends StatefulWidget {
  const BasketSortBottomSheet({
    super.key,
    required this.selectedSortingOption,
  });

  final String selectedSortingOption;

  @override
  State<BasketSortBottomSheet> createState() => _BasketSortBottomSheetState();
}

class _BasketSortBottomSheetState extends State<BasketSortBottomSheet> {
  String selectedSortingOption = '';

  @override
  void initState() {
    super.initState();
    selectedSortingOption = widget.selectedSortingOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Gap(4),
              const FaIcon(
                FontAwesomeIcons.sort,
                size: 16,
                color: Colors.black,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
          _SortByItemWidget(
            onTap: () {
              context
                  .read<NeoBasketDiscoveryCubit>()
                  .getNeoBasketDiscoveryBaskets(
                    NeobasketDiscoveryParams(
                      searchTerm: '',
                      sortBy: 'CAGR',
                    ),
                  );

              Navigator.pop(context, 'CAGR');
            },
            title: 'CAGR',
            trailing: selectedSortingOption == 'CAGR'
                ? Assets.svgs.sortUp.svg()
                : const FaIcon(
                    FontAwesomeIcons.percentage,
                    color: Color(0xFFB0B0B0),
                  ),
          ),
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
          _SortByItemWidget(
            onTap: () {
              context
                  .read<NeoBasketDiscoveryCubit>()
                  .getNeoBasketDiscoveryBaskets(
                    NeobasketDiscoveryParams(
                      searchTerm: '',
                      sortBy: 'RISK',
                    ),
                  );

              Navigator.pop(context, 'RISK');
            },
            title: 'Risk Appetite',
            trailing: selectedSortingOption == 'RISK'
                ? Assets.svgs.sortUp.svg()
                : Assets.svgs.sortRiskAppetiteIcon.svg(),
          ),
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
          _SortByItemWidget(
            onTap: () {
              context
                  .read<NeoBasketDiscoveryCubit>()
                  .getNeoBasketDiscoveryBaskets(
                    NeobasketDiscoveryParams(
                      searchTerm: '',
                      sortBy: 'INVEST',
                    ),
                  );

              Navigator.pop(context, 'INVEST');
            },
            title: 'Investment',
            trailing: selectedSortingOption == 'INVEST'
                ? Assets.svgs.sortUp.svg()
                : Assets.svgs.sortInvestmentIcon.svg(),
          ),
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class _SortByItemWidget extends StatelessWidget {
  const _SortByItemWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.trailing,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
