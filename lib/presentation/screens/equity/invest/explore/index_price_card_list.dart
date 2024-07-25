import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/params/equity/equity_explore/index_price_params.dart';
import '../../../../cubits/equity/equity_explore/index_price_banner_cubit.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../component/day_change_banner.dart';

class IndexPriceCardList extends StatelessWidget {
  const IndexPriceCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexPriceBannerCubit, IndexPriceBannerState>(
      builder: (context, state) {
        if (state is IndexPriceBannerLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is IndexPriceBannerFailure) {
          return AppErrorWidget(
            errorType: state.errorType,
            error: state.errorMessage,
            onRetry: () =>
                context.read<IndexPriceBannerCubit>().fetchIndexPrice(
                      IndexPriceParams(
                        [
                          "NSEI",
                          "CNX100",
                          "NSEBANK",
                          "CNXIT",
                          "CNXFMCG",
                          "CNXAUTO",
                          "CNX200",
                        ],
                      ),
                    ),
          );
        }
        if (state is IndexPriceBannerLoaded) {
          final banner = state.indexPriceModel;
          return SizedBox(
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: banner.length,
              itemBuilder: (context, index) {
                return DayChangeBanner(
                  name: banner[index].symbolName,
                  close: banner[index].close,
                  day: banner[index].oneDayChange,
                  dayPercentage: banner[index].oneDayPercentChange,
                  week: banner[index].oneWeekChange,
                  weekPercentage: banner[index].oneWeekPercentChange,
                  month: banner[index].oneMonthChange,
                  monthPercentage: banner[index].oneMonthPercentChange,
                  year: banner[index].oneYearChange,
                  yearPercentage: banner[index].oneYearPercentChange,
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
