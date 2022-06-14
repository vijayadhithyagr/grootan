
import 'package:flutter/material.dart';
import 'package:grootan/utils/constants.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppConstants.KCENTER_DESIGN_COLOR
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.1071111);
    path0.quadraticBezierTo(
        0, size.height * 0.7251111, 0, size.height * 0.9311111);
    path0.quadraticBezierTo(size.width * 0.0001667, size.height * 1.0151111,
        size.width * 0.0516667, size.height);
    path0.lineTo(size.width * 0.9333333, size.height);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeadCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = AppConstants.KTOP_DESIGN_COLOR
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(0,0);
    path0.lineTo(size.width*0.0183250,size.height*0.1956500);
    path0.quadraticBezierTo(size.width*0.2459000,size.height*1.3190250,size.width*0.7891000,size.height*0.7732750);
    path0.quadraticBezierTo(size.width*0.8895250,size.height*0.7145750,size.width,size.height*0.4143500);
    path0.lineTo(size.width,0);

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}



