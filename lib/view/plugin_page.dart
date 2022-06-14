// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan/controller/login_details_controller.dart';
import 'package:grootan/utils/constants.dart';
import 'package:grootan/view/login_details_page.dart';
import 'package:grootan/widgets/button_widget.dart';
import 'package:grootan/widgets/custom_painter_widget.dart';
import 'package:grootan/widgets/heading_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PluginPage extends StatelessWidget {
  PluginPage({Key? key}) : super(key: key);

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
                    // IconButton(
                    //     onPressed: () => Get.back(),
                    //     icon: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: Colors.white,
                    //     )),
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
                          child:GestureDetector(
                            onTap: () {
                              controller.logoutUser();
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppConstants.KPRIMARY_BACKGROUND_COLOR,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.22,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                color: AppConstants.KPRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomPaint(
                                size: Size(size.width, 180),
                                painter: RPSCustomPainter(),
                              ),
                            ),
                            Positioned(
                              top: -95,
                              child: Container(
                                width: size.width,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: QrImage(
                                        data: "${controller.qrCodeNumber}",
                                        version: QrVersions.auto,
                                        size: 165.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Generated Number',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: AppConstants.KLARGE_FONT),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${controller.qrCodeNumber}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              AppConstants.KEXTRA_LARGE_FONT),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => LoginDetailsPage());
                                },
                                child: Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppConstants
                                          .KPRIMARY_BACKGROUND_COLOR),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Last login at ${controller.lastLogin.value}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppConstants.KMEDIUM_FONT,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GetBuilder<LoginDetailsController>(
                                  builder: (controller) {
                                return controller.isProgress == false
                                    ? GestureDetector(
                                        onTap: () async {
                                          controller
                                              .generateQrImage(context);
                                        },
                                        child: ButtonWidget(title: 'SAVE'),
                                      )
                                    : Container(
                                        height: 65,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                              }),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: -18,
                      child: HeadingWidget(
                        heading: 'PLUGIN',
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
