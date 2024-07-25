import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../data/models/user/user.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../routes/routes.dart';
import 'widgets/profile_image.dart';
import 'widgets/profile_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.read<AuthCubit>().state.user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ProfileListTiles(
            title: user.userName ?? 'Guest',
            subTitle: 'View your account details',
            icon: const Hero(
              tag: 'profile_image',
              child: ProfileImage(size: 45),
            ),
            routeName: Routes.accountDetails,
            isProfileTile: true,
          ),
          const Gap(8.0),
          ProfileListTiles(
            title: 'AutoMandates',
            subTitle: 'Edit Bank and Auto Mandates',
            icon: Assets.icons.profileAutoMandate
                .image(height: 30.0, width: 30.0),
            routeName: Routes.bankDetails,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'Delivery Address',
            subTitle: 'Edit delivery address for Digital Gold',
            icon: Assets.icons.profileDeliveryAddress
                .image(height: 30.0, width: 30.0),
            routeName: Routes.deliveryAddress,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'Security Options',
            subTitle: 'Change mPIN',
            icon: Assets.icons.profileSecurityOptions
                .image(height: 30.0, width: 30.0),
            routeName: Routes.securityOptions,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'About Neosurge',
            subTitle: 'Terms & Conditions, Privacy Policy, FAQs',
            icon: Assets.icons.profileAboutUs.image(height: 30.0, width: 30.0),
            routeName: Routes.aboutUs,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'Reports',
            subTitle: 'View all your mutual fund reports here',
            icon: Assets.icons.profileReports.image(height: 30.0, width: 30.0),
            routeName: Routes.reports,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'Orders',
            subTitle: 'Get a glimpse of your order history',
            icon: Assets.icons.profileOrders.image(height: 30.0, width: 30.0),
            routeName: Routes.newOrderScreen,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'Contact Us',
            subTitle: 'Get in touch with our support team',
            icon: Assets.icons.profilePhone.image(height: 30.0, width: 30.0),
            routeName: Routes.contactUs,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 1),
          ),
          ProfileListTiles(
            title: 'Logout',
            subTitle: 'Logout from your account',
            icon: Assets.icons.profileLogout.image(height: 30.0, width: 30.0),
            routeName: Routes.logout,
            isLogOutButton: true,
          ),
          const Gap(24.0),
        ],
      ),
    );
  }

  BoxDecoration get boxDecoration => const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      );

  EdgeInsets get containerPadding => const EdgeInsets.all(12.0);
}
