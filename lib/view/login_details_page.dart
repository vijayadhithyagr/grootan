// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:grootan/widgets/custom_painter_widget.dart';
import 'package:grootan/widgets/heading_widget.dart';
import 'package:grootan/widgets/show_detail_widget.dart';
import 'package:intl/intl.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan/controller/login_details_controller.dart';
import 'package:grootan/utils/constants.dart';
import 'package:grootan/view/login.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoginDetailsPage extends StatelessWidget {
  LoginDetailsPage({Key? key}) : super(key: key);

  LoginDetailsController controller = Get.put(LoginDetailsController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.KPRIMARY_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: AppConstants.KPRIMARY_COLOR,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    Spacer(),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 180,
                          width: 100,
                          // decoration: BoxDecoration(
                          //   color: AppConstants.KPRIMARY_COLOR,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: CustomPaint(
                            size: Size(90, 180),
                            painter: HeadCustomPainter(),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 10,
                          child:GestureDetector(
                            onTap: () {
                              controller.logoutUser(isDetails: true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppConstants.KLARGE_FONT),
                              ),
                            ),
                          ) ,
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                      color: AppConstants.KPRIMARY_BACKGROUND_COLOR,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 30,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.changeIndex(0);
                                },
                                child: GetX<LoginDetailsController>(
                                    builder: (controller) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                            controller.changeIndexValue.value ==
                                                    0
                                                ? Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 3))
                                                : null),
                                    child: Center(
                                      child: Text(
                                        controller.changeIndexValue.value == 0
                                            ? 'Today'.toUpperCase()
                                            : 'Today',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.changeIndex(1);
                                },
                                child: GetX<LoginDetailsController>(
                                    builder: (controller) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                            controller.changeIndexValue.value ==
                                                    1
                                                ? Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 3))
                                                : null),
                                    child: Center(
                                      child: Text(
                                        controller.changeIndexValue.value == 1
                                            ? 'Yesterday'.toUpperCase()
                                            : 'Yesterday',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.changeIndex(2);
                                },
                                child: GetX<LoginDetailsController>(
                                    builder: (controller) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                            controller.changeIndexValue.value ==
                                                    2
                                                ? Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 3))
                                                : null),
                                    child: Center(
                                      child: Text(
                                        controller.changeIndexValue.value == 2
                                            ? 'Other'.toUpperCase()
                                            : 'Other',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: GetX<LoginDetailsController>(
                              builder: (controller) {
                            return controller.changeIndexValue.value == 0
                                ? ShowDetails(
                                    loginDetailsList:
                                        controller.todayLoginDetailsList,
                                  )
                                : controller.changeIndexValue.value == 1
                                    ? ShowDetails(
                                        loginDetailsList: controller
                                            .yesterdayLoginDetailsList,
                                      )
                                    : ShowDetails(
                                        loginDetailsList:
                                            controller.loginDetailsList,
                                      );
                          }),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -18,
                    child: HeadingWidget(heading: 'LAST LOGIN'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
