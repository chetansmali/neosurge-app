import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../domain/entities/params/equity/equity_watchlist/create_watchlist_params.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/equity_watchlist/create_watchlist_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart';
import '../../../../theme/app_colors.dart';

class MyBottomSheet extends StatefulWidget {
  final bool refreshWatchlist;

  const MyBottomSheet({
    super.key,
    this.refreshWatchlist = true,
  });

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final TextEditingController _textEditingController = TextEditingController();
  final _watchlistFormket = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(25),
            Form(
              key: _watchlistFormket,
              child: TextFormField(
                controller: _textEditingController,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (val) {
                  if (_watchlistFormket.currentState!.validate()) {
                    context.read<CreateWatchlistCubit>().createWatchlist(
                          CreateWatchlistParams(
                            name: _textEditingController.text,
                          ),
                        );
                  }
                },
                autofocus: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter watchlist name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: AppColors.primaryWhite,
                  labelText: 'watchlist name',
                  floatingLabelStyle:
                      const TextStyle(color: AppColors.primaryColor),
                  labelStyle: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            const Gap(26),
            ElevatedButton(
              onPressed: () {
                if (_watchlistFormket.currentState!.validate()) {
                  context.read<CreateWatchlistCubit>().createWatchlist(
                        CreateWatchlistParams(
                          name: _textEditingController.text,
                        ),
                      );
                }
              },
              child: BlocConsumer<CreateWatchlistCubit, CreateWatchlistState>(
                listener: (_, state) {
                  if (state is CreateWatchlistLoaded) {
                    if (widget.refreshWatchlist) {
                      context
                          .read<GetAllUserWatchlisCubit>()
                          .fetchAllWatchlist();
                    }
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return state is CreateWatchlistLoading
                      ? Assets.animations.loading.lottie()
                      : const Text('Create');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
