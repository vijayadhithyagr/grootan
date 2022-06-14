
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grootan/utils/constants.dart';

class HeadingWidget extends StatelessWidget {
  final String heading;
  const HeadingWidget({Key? key,required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.KHEADER_BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 5),
        child: Text(
          heading,
          style: TextStyle(
            fontSize: AppConstants.KEXTRA_LARGE_FONT,
            color: Colors.white,
          ),
        ),
      ),
    );

  }
}
