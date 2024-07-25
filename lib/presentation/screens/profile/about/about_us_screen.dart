import 'package:flutter/material.dart';

import '../../../../core/api/api_constants.dart';
import '../../../../flavors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import 'about_neosurge_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Assets.icons.aboutCompany.image(height: 32.0, width: 32.0),
            title: const Text('About Us'),
            trailing:
                Assets.icons.profileTileArrow.image(height: 20.0, width: 20.0),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AboutNeosurgeScreen())),
          ),
          const Divider(
            thickness: 1,
            indent: 30.0,
            endIndent: 30.0,
          ),
          ListTile(
            leading: Assets.icons.faqs.image(height: 32.0, width: 32.0),
            title: const Text('FAQs'),
            trailing:
                Assets.icons.profileTileArrow.image(height: 20.0, width: 20.0),
            onTap: () => Navigator.pushNamed(context, Routes.aboutWebView,
                arguments: AboutWebViewArgs(
                  url: F.baseUrl + ApiConstants.faq,
                  title: 'FAQs',
                )),
          ),
          const Divider(
            thickness: 1,
            indent: 30.0,
            endIndent: 30.0,
          ),
          ListTile(
            leading:
                Assets.icons.profileAboutUs.image(height: 32.0, width: 32.0),
            title: const Text('Terms & Conditions'),
            trailing:
                Assets.icons.profileTileArrow.image(height: 20.0, width: 20.0),
            onTap: () => Navigator.pushNamed(
              context,
              Routes.aboutWebView,
              arguments: AboutWebViewArgs(
                  url: '${F.baseUrl}${ApiConstants.termsAndConditions}',
                  title: 'Terms and Conditions'),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 30.0,
            endIndent: 30.0,
          ),
          ListTile(
            leading:
                Assets.icons.privacyPolicy.image(height: 32.0, width: 32.0),
            title: const Text('Privacy Policy'),
            trailing:
                Assets.icons.profileTileArrow.image(height: 20.0, width: 20.0),
            onTap: () => Navigator.pushNamed(context, Routes.aboutWebView,
                arguments: const AboutWebViewArgs(
                  url:
                      'https://www.freeprivacypolicy.com/live/8c2b4969-4e11-4a73-afb1-843b2b5278f5',
                  title: 'Privacy Policy',
                )),
          ),
          const Divider(
            thickness: 1,
            indent: 30.0,
            endIndent: 30.0,
          ),
        ],
      ),
    );
  }
}
