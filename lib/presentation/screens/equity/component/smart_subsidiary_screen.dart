import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../data/models/equity/smart_filtering/business_houses_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/params/equity/smart_filter_subsidiaries/get_subsidiaries_params.dart';
import '../../../cubits/equity/smart_filter_subsidiaries/cubit/get_business_houses_cubit.dart';
import '../../../cubits/equity/smart_filter_subsidiaries/cubit/get_subsidiaries_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import '../invest/explore/smart_subsidiary_single_screen.dart';

class SmartSubsidiaryScreen extends StatelessWidget {
  const SmartSubsidiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subsidiary'),
      ),
      body: BlocBuilder<GetBusinessHousesCubit, GetBusinessHousesState>(
          builder: (context, state) {
        if (state is GetBusinessHousesInitial ||
            state is GetBusinessHousesLoading) {
          return const Center(
            child: CustomLoader(),
          );
        }

        if (state is GetBusinessHousesFailure) {
          return Center(
            child: AppErrorWidget(
                errorType: state.errorType, error: state.errorMessage),
          );
        }

        if (state is GetBusinessHousesSuccess) {
          final List<BusinessHouseModel> businessHouses = state.businessHouses;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              itemCount: businessHouses.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _StockGroupWidget(
                  businessHouse: businessHouses[index],
                );
              },
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}

class _StockGroupWidget extends StatelessWidget {
  const _StockGroupWidget({required this.businessHouse});
  final BusinessHouseModel businessHouse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => getIt<GetSubsidiariesCubit>()
                        ..getSubsidiaries(GetSubsidiariesParams(
                          businessHouse: businessHouse.businessHouseEnum!,
                          page: 0,
                          size: 100,
                          sort: 'marketCapitalization,DESC',
                        )),
                      child: SmartSubsidiarySingleScreen(
                        businessHouse: businessHouse.businessHouse!,
                        businessHouseEnum: businessHouse.businessHouseEnum!,
                      ),
                    )));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral[50]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: Center(
                        child: businessHouse.icon != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: businessHouse.icon!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Text(
                                    businessHouse.businessHouse!
                                        .substring(0, 1),
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                businessHouse.businessHouse!.substring(0, 2)),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      businessHouse.businessHouse ?? '--',
                      style: baseTextStyle12500,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      businessHouse.count != null
                          ? '${businessHouse.count!} ' 'stocks'
                          : '--',
                      style: baseTextStyle12400.copyWith(
                          color: const Color(0xFF727579)),
                    ),
                    const RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF2E8EFF),
                          size: 16,
                        ))
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
