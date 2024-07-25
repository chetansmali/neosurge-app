import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/digital_gold/checkout_rates_cubit/get_checkout_rates_cubit.dart';
import '../../../cubits/digital_gold/create_order_cubit/create_order_cubit.dart';
import '../../../cubits/digital_gold/sell_gold_silver_cubit/sell_gold_silver_cubit.dart';
import '../../../theme/app_colors.dart';
import '../digital_gold_purchase_screen.dart';

class DGBuySellButtons extends StatelessWidget {
  final MetalType metalType;

  const DGBuySellButtons({Key? key, required this.metalType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _BuySellNavButton(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => getIt<GetCheckoutRatesCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => getIt<CreateOrderCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => getIt<SellGoldSilverCubit>(),
                      )
                    ],
                    child: DigitalGoldPurchaseScreen(
                      metalType: metalType,
                      isBuying: false,
                    ),
                  ),
                )),
            isBuying: false,
          ),
        ),
        const Gap(24),
        Expanded(
          child: _BuySellNavButton(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => getIt<GetCheckoutRatesCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => getIt<CreateOrderCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => getIt<SellGoldSilverCubit>(),
                      )
                    ],
                    child: DigitalGoldPurchaseScreen(
                      metalType: metalType,
                      isBuying: true,
                    ),
                  ),
                )),
            isBuying: true,
          ),
        ),
      ],
    );
  }
}

class _BuySellNavButton extends StatelessWidget {
  const _BuySellNavButton({
    required this.onTap,
    required this.isBuying,
  });
  final Function() onTap;
  final bool isBuying;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: isBuying ? null : Border.all(color: AppColors.primaryColor),
          color: isBuying ? AppColors.primaryColor : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          isBuying ? 'Buy' : 'Sell',
          style: baseTextStyle16500.copyWith(
              color: isBuying ? Colors.white : AppColors.primaryColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
