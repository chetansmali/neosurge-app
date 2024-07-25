import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../domain/entities/params/equity/equity_smart_watchlist/get_users_alert_params.dart';
import '../../../../../../domain/entities/params/equity/equity_smart_watchlist/remove_alert_params.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/get_user_alerts_cubit.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/remove_alert_cubit.dart';

class DeleteDialog extends StatelessWidget {
  final List<String> deleteWatchlist;

  const DeleteDialog({super.key, required this.deleteWatchlist});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ), // this is the key
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 8,
          top: 24,
          left: 16,
          right: 16,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // To make the dialog compact
            children: <Widget>[
              Text(
                'Are you sure you want to delete these stocks from watchlist?',
                textAlign: TextAlign.center,
                style: baseTextStyle14500,
              ),
              const Gap(42),
              ElevatedButton(
                onPressed: () {
                  context.read<RemoveAlertCubit>().deleteAlert(
                      RemoveAlertParams(
                          alertIds: deleteWatchlist.toSet().toList()));
                  deleteWatchlist.clear();
                },
                child: BlocConsumer<RemoveAlertCubit, RemoveAlertState>(
                  listener: (context, state) {
                    if (state is RemoveAlertLoaded) {
                      if (state.removeAlertModel.success!) {
                        context.read<GetUserAlertsCubit>().fetchUserAlerts(
                            GetUsersAlertParams(page: 0, size: 25, sort: ''));
                        Navigator.pop(context);
                        Utils.showSuccessAlert(
                            context, state.removeAlertModel.message ?? '');
                      } else {
                        Navigator.pop(context);
                        Utils.showWarningAlert(
                            context, state.removeAlertModel.message ?? '');
                      }
                    }
                  },
                  builder: (context, state) {
                    return state is RemoveAlertLoading
                        ? Assets.animations.loading.lottie()
                        : Text(
                            'Delete',
                            style: baseTextStyle12500,
                          );
                  },
                ),
              ),
              const Gap(10),
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(250, 48),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: baseTextStyle12500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
