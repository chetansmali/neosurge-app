import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../cubits/assisted_service/assisted_orders/assisted_orders_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../widgets/modified_expansion_tile.dart';
import '../../../widgets/widgets.dart';
import 'pending_order_card.dart';

const _kDuration = Duration(milliseconds: 400);

class AssistedPendingOrdersList extends HookWidget {
  const AssistedPendingOrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => ExpandableSliverListController(
        initialStatus: ExpandableSliverListStatus.collapsed,
      ),
    );

    useEffect(() => () => controller.dispose(), const []);
    return MultiSliver(
      children: [
        BlocBuilder<AssistedOrdersCubit, AssistedOrdersState>(
          // listenWhen: (previous, current) =>
          //     previous is AssistedOrdersLoaded && current is AssistedOrdersLoaded,
          // listener: (context, state) {
          //   if (state is AssistedOrdersLoaded) {
          //     controller.insertItem(state.orders[0], 0);
          //   }
          // },
          builder: (context, state) {
            if (state is AssistedOrdersLoading) {
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
            if (state is AssistedOrdersLoadError) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
                onRetry: () => context
                    .read<AssistedOrdersCubit>()
                    .fetchPendingOrders(
                        userId: context.read<AuthCubit>().state.user!.id),
              );
            }
            if (state is AssistedOrdersLoaded) {
              if (state.orders.isEmpty) {
                return const SizedBox.shrink();
              }
              return MultiSliver(
                children: [
                  SliverPinnedHeader(
                    child: ModifiedExpansionTile(
                      title: Text(
                        'Order in Progress (${state.orders.length})',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      onExpansionChanged: (bool isExpanded) => isExpanded
                          ? controller.expand()
                          : controller.collapse(),
                      initiallyExpanded: false,
                      duration: _kDuration,
                    ),
                  ),
                  SliverClip(
                    child: ExpandableSliverList(
                        initialItems: state.orders,
                        builder: ((context, item, index) =>
                            PendingOrderItem(order: state.orders[index])),
                        duration: _kDuration,
                        controller: controller),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
