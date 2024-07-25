import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../data/models/user/assisted_service_user_details.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/assisted_service/assited_holdings_cubit/assisted_holdings_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/get_fund_by_isin/get_fund_by_isin_cubit.dart';
import '../../../cubits/mutual_funds/mf_sort_by_switch/mf_sort_by_switch_cubit.dart';
import '../../../cubits/mutual_funds/mf_user_holdings/mf_user_holdings_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/modified_expansion_tile.dart';
import '../../../widgets/widgets.dart';
import 'assisted_service_fund_card.dart';

const _kDuration = Duration(milliseconds: 400);

class AssistedHoldingsList extends HookWidget {
  const AssistedHoldingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => ExpandableSliverListController<UserMfScheme>(
        initialStatus: ExpandableSliverListStatus.collapsed,
      ),
    );
    AssistedServiceUserDetails assistedDetails =
        context.read<AuthCubit>().state.user!.assistedServiceUserDetails!;

    useEffect(() => () => controller.dispose(), const []);
    return MultiSliver(
      children: [
        BlocBuilder<AssistedHoldingsCubit, AssistedHoldingsState>(
          builder: (context, state) {
            if (state is AssistedHoldingsLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmer(
                      width: 100,
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomShimmer(
                          width: 100,
                        ),
                        CustomShimmer(
                          width: 100,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            if (state is AssistedHoldingsError) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.error,
                onRetry: () => context
                    .read<MfUserHoldingsCubit>()
                    .getUserHoldings(
                        userId: context.read<AuthCubit>().state.user!.id),
              );
            }
            if (state is AssistedHoldingsLoaded) {
              if (state.userMfHoldings == null) {
                return const SizedBox.shrink();
              }
              return MultiSliver(children: [
                SliverPinnedHeader(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ModifiedExpansionTile(
                        title: Text(
                          'My Mutual Funds (${state.userMfHoldings!.schemes.length})',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        onExpansionChanged: (bool isExpanded) => isExpanded
                            ? controller.expand()
                            : controller.collapse(),
                        duration: _kDuration,
                        initiallyExpanded: false,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sort',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<MfSortBySwitchCubit>()
                                        .switchSortBy();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BlocBuilder<MfSortBySwitchCubit,
                                          MfSortBySwitchState>(
                                        builder: (context, state) {
                                          return _SortTextWidget(
                                            state.sortBy,
                                          );
                                        },
                                      ),
                                      const Gap(2),
                                      Assets.icons.swapVertical.svg(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverClip(
                  child: BlocProvider(
                    create: (context) => getIt<GetFundByIsinCubit>(),
                    child: ExpandableSliverList<UserMfScheme>(
                        initialItems: state.userMfHoldings!.schemes,
                        builder: (context, item, index) =>
                            AssistedServiceFundCard(
                                scheme: item,
                                isCurrentlyAssistedUser:
                                    !assistedDetails.isExpired),
                        duration: _kDuration,
                        controller: controller),
                  ),
                )
              ]);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _SortTextWidget extends StatelessWidget {
  final MFSortBy sortBy;

  const _SortTextWidget(this.sortBy, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sortBy.toString(),
      style: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w600),
    );
  }
}
