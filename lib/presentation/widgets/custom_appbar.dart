import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../common/debouncer.dart';
import '../../di/get_it.dart';
import '../../gen/assets.gen.dart';
import '../cubits/authentication/auth/auth_cubit.dart';
import '../cubits/mutual_funds/search_funds/search_fund_cubit.dart';
import '../routes/routes.dart';
import '../screens/notifications/widget/notification_icon.dart';
import 'custom_search_delegate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: SizedBox(
            height: 20,
            width: 20,
            child: Assets.svgs.neoLogo.svg(),
          ),
          leadingWidth: 30,
          title: Text.rich(
            TextSpan(
              text: 'Hello,\n',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: context.read<AuthCubit>().state.user!.userName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              child: Assets.icons.magniferHome.svg(),
              onTap: () async {
                final searchFundCubit = getIt<SearchFundCubit>();
                final debouncer = Debouncer(milliseconds: 300);
                await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      debouncer: debouncer, searchFundCubit: searchFundCubit),
                );
                searchFundCubit.close();
                debouncer.close();
              },
            ),
            const Gap(24),
            const NotificationIcon(),
            const Gap(24),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.profile),
              child: Assets.icons.appBarProfile.svg(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
