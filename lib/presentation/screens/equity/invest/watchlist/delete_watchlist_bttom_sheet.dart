import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../domain/entities/params/equity/equity_watchlist/delete_watchlist_params.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/remove_watchlist_cubit.dart';

class DeleteWatchlistBottomsheet extends StatefulWidget {
  final int watchlistId;
  const DeleteWatchlistBottomsheet({super.key, required this.watchlistId});

  @override
  State<DeleteWatchlistBottomsheet> createState() =>
      _DeleteWatchlistBottomsheetState();
}

class _DeleteWatchlistBottomsheetState
    extends State<DeleteWatchlistBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Are you sure?', style: baseTextStyle2),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Assets.icons.crossIcon.image(height: 24, width: 24)),
              ],
            ),
            const Gap(20),
            Text(
                'You will not be able to restore the watchlist once deleted. Delete anyway?',
                style: baseTextStyle1),
            const Gap(40),
            ElevatedButton(
              onPressed: () {
                context.read<RemoveWatchlistCubit>().deleteWatchlist(
                      DeleteWatchlistParams(
                        id: widget.watchlistId.toString(),
                      ),
                    );
              },
              child: BlocConsumer<RemoveWatchlistCubit, RemoveWatchlistState>(
                listener: (_, state) {
                  if (state is RemoveWatchlistSuccess) {
                    context.read<GetAllUserWatchlisCubit>().fetchAllWatchlist();
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return state is RemoveWatchlistLoading
                      ? Assets.animations.loading.lottie()
                      : const Text('Delete');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
