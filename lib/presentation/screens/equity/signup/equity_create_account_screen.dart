import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../gen/assets.gen.dart';
import 'images_items.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  final List<Widget> imageList = [
    Assets.pngs.equityZerodhaBroker.image(),
    Assets.pngs.equityUpstoxBroker.image(),
    Assets.pngs.equityIcicBroker.image(),
  ];
  final List<String> imageName = [
    "Zerodha",
    "Upstox",
    "Icic",
  ];
  final List<String> brokerURL = [
    "https://zerodha.com/open-account?c=ZAPDSD",
    'https://upstox.com/open-account/?f=3EA34V',
    "https://secure.icicidirect.com/accountopening?rmcode=BISA4010",
  ];

  final PageController _pageController = PageController();
  int selectIndex = -1;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create DEMAT account'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(30),
                const Text('We support these brokers'),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 240,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 18.0,
                      ),
                      itemCount: imageList.length,
                      itemBuilder: (context, innerIndex) {
                        return ImageItems(
                          imageUrl: imageList[innerIndex],
                          isSelected: innerIndex == selectIndex,
                          onTap: () {
                            setState(() {
                              selectIndex = innerIndex;
                            });
                          },
                          name: imageName[innerIndex],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _callSmallcase(brokerURL[selectIndex]);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(335, 56),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _callSmallcase(String brokerURL) async {
    if (await canLaunchUrl(Uri.parse(brokerURL))) {
      await launchUrl(
        Uri.parse(brokerURL),
      );
    } else {
      throw 'Could not launch $brokerURL';
    }
  }
}
