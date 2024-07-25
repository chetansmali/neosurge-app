import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BannerContainer extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final String? buttonText;

  const BannerContainer({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFDDDDDD))),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: image),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const Gap(20),
                Text(subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                    )),
                const Gap(20),
                if (onTap != null)
                  SizedBox(
                    width: 120,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: onTap,
                      child: Text(
                        '$buttonText',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
