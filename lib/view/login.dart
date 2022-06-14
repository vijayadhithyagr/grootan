// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grootan/controller/auth_controller.dart';
import 'package:grootan/utils/constants.dart';
import 'package:grootan/view/plugin_page.dart';
import 'package:grootan/widgets/button_widget.dart';
import 'package:grootan/widgets/custom_painter_widget.dart';
import 'package:grootan/widgets/heading_widget.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
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
                    Spacer(),
                    Container(
                      height: 180,
                      width: 100,
                      // decoration: BoxDecoration(
                      //   color: AppConstants.KPRIMARY_COLOR,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: CustomPaint(
                        size: Size(100, 180),
                        painter: HeadCustomPainter(),
                      ),
                    ),
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
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppConstants.KPRIMARY_BACKGROUND_COLOR,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.8,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text(
                                'Phone Number',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppConstants.KLARGE_FONT),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: Colors.white,
                                controller: controller.phoneController,
                                style: TextStyle(color: Colors.white),
                                onEditingComplete: () {
                                  controller.checkPhoneDigit(context);
                                },
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    counterText: '',
                                    filled: true,
                                    fillColor: AppConstants.KPRIMARY_COLOR),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'OTP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppConstants.KLARGE_FONT),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: controller.otpController,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                // buildCounter: (BuildContext context, {int currentLength!, int maxLength!, bool isFocused!}) =>null,
                                onTap: () {
                                  controller.checkPhoneDigit(context);
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    counterText: '',
                                    filled: true,
                                    fillColor: AppConstants.KPRIMARY_COLOR),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              GetBuilder<AuthController>(builder: (controller) {
                                return controller.isProgress == false
                                    ? GestureDetector(
                                        onTap: () async {

                                            controller.loginUser(context);

                                        },
                                        child: ButtonWidget(title: 'LOGIN'),
                                      )
                                    : Container(
                                        height: 65,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: -18,
                      child: HeadingWidget(
                        heading: 'LOGIN',
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
