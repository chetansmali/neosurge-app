import 'package:flutter/material.dart';

import '../../common/common.dart';

class ORDivider extends StatelessWidget {
  const ORDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: const Color(0xFFE6E6E6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0,bottom: 2,left: 12,right: 12),
          child: Text('or',style: baseTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }
}
