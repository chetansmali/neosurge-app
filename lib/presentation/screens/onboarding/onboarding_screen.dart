import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import 'onboarding_stories/onboarding_stories_view.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingStoriesView(
        onboardingData: [
          {
            'title': 'Mutual Funds,Stocks & Metals',
            'description':
                'Invest across major investment instruments and create wealth over time',
            'image':
                Assets.pngs.onboardingFlower1.image(height: 320, width: 300),
            'backgroundColor': 'assets/pngs/onboarding_blue_bg1.png'
          },
          {
            'title': 'Prepaid Cards,Rewards & Luxury',
            'description':
                'Spend from your prepaid card, earn on every swipe and enjoy rewards and offers',
            'image':
                Assets.pngs.onboardingLuminaCard.image(height: 320, width: 320),
            'backgroundColor': 'assets/pngs/onboarding_blue2_bg1.png'
          },
          {
            'title': 'Analysis, AI  & Portfolio Management',
            'description':
                'Get analysis on your portfolio, chat with our AI finance support and manage your portfolio at ease. It’s that easy!',
            'image':
                Assets.gifs.onboardingNeoGIF.image(height: 280, width: 280),
            'backgroundColor': 'assets/pngs/onboarding_black_bg1.png'
          },
          {
            'title': 'One app for all your Finance needs!',
            'description':
                'Avail Loans, Streamline Credits, Keep up with market news all from the single app. Your only one app for all your finance needs!',
            'image': Assets.pngs.onboardingStar4.image(height: 320, width: 300),
            'backgroundColor': 'assets/pngs/onboarding_grey_bg1.png'
          },
        ],
      ),
    );
  }
}
