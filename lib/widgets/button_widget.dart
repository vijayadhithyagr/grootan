
import 'package:flutter/material.dart';
import 'package:grootan/utils/constants.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  const ButtonWidget({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppConstants.KBUTTON_COLOR),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: AppConstants.KLARGE_FONT,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );

  }
}
