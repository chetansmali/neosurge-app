import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../data/models/digital_gold/gold_user.dart';
import '../../../cubits/digital_gold/delivery_product_cubit/delivery_product_cubit.dart';
import '../../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';
import 'widgets/deliver_info_card.dart';

class SilverDeliverTabView extends StatefulWidget {
  const SilverDeliverTabView({Key? key}) : super(key: key);

  @override
  State<SilverDeliverTabView> createState() => _SilverDeliverTabViewState();
}

class _SilverDeliverTabViewState extends State<SilverDeliverTabView>
    with AutomaticKeepAliveClientMixin<SilverDeliverTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<DeliveryProductCubit, DeliveryProductState>(
      builder: (context, state) {
        if (state is DeliveryProductLoading) {
          return const Center(child: CustomLoader());
        }
        if (state is DeliveryProductError) {
          return Center(
              child: Text(Utils.getErrorMessage(
                  errorType: state.appErrorType, msg: state.errorMessage)));
        }
        if (state is DeliveryProductLoaded) {
          final GoldUser goldUser =
              context.read<GoldUserCubit>().state.goldUser!;

          state.deliveryProducts
              .sort((a, b) => a.basePrice.compareTo(b.basePrice));

          return Column(
            children: [
              const Gap(8.0),
              if (goldUser.transactionalSilverBalance <
                  state.deliveryProducts[0].reedemWeight)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.error[50],
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_rounded,
                        color: AppColors.errorRed,
                      ),
                      const Gap(4.0),
                      Text(
                        'Not enough silver balance to buy coins',
                        style: baseTextStyle12400.copyWith(
                          color: AppColors.errorRed,
                        ),
                      )
                    ],
                  ),
                ),
              const Gap(8.0),
              Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return DeliverInfoCard(
                          deliveryProduct: state.deliveryProducts[index]);
                    },
                    itemCount: state.deliveryProducts.length),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
