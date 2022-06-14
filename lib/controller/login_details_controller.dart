// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grootan/model/login_details_model.dart';
import 'package:grootan/model/location_details_model.dart';
import 'package:grootan/repository/location_details_repository.dart';
import 'package:grootan/utils/constants.dart';
import 'package:grootan/view/plugin_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grootan/view/login.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get_storage/get_storage.dart';

class LoginDetailsController extends GetxController {
  LocationDetailsRepository repository = LocationDetailsRepository();
  final box = GetStorage();

  RxInt changeIndexValue = 0.obs;
  bool isProgress = false;
  RxInt qrCodeNumber = 0.obs;
  RxString lastLogin = ''.obs;
  RxString qrImageUrl = ''.obs;
  GetIpLocation currentLocationData = GetIpLocation();
  RxList<GetLoginDetailsModel> loginDetailsList = <GetLoginDetailsModel>[].obs;
  RxList<GetLoginDetailsModel> todayLoginDetailsList =
      <GetLoginDetailsModel>[].obs;
  RxList<GetLoginDetailsModel> yesterdayLoginDetailsList =
      <GetLoginDetailsModel>[].obs;

  @override
  void onInit() async {
    getLastLoginTime();
    getLoginDetails();
    initialSetValues();
    super.onInit();
  }

  initialSetValues() {
    if (box.read('qrNumber') != null && box.read('qrNumber') != 0) {

      qrCodeNumber.value = box.read('qrNumber');
      qrImageUrl.value = box.read('imageUrl');
      getIpLocationDetails();
    } else {
      generateRandomNumber();
    }
  }

  logoutUser({bool isDetails = false}) {
    FirebaseAuth.instance.signOut();
    box.erase();
    Get.offAll(()=>Login());


  }

  getLastLoginTime() {
    DateTime now = DateTime.now();
    if (DateFormat('yyyy-MM-dd').format(now) ==
        DateFormat('yyyy-MM-dd').format(
            FirebaseAuth.instance.currentUser!.metadata.lastSignInTime!)) {
      lastLogin.value =
          'Today, ${DateFormat('hh:mm a').format(FirebaseAuth.instance.currentUser!.metadata.lastSignInTime!)}';
    } else {
      lastLogin.value =
          ' ${DateFormat('dd MMM hh:mm a').format(FirebaseAuth.instance.currentUser!.metadata.lastSignInTime!)}';
    }
  }

  changeIndex(int index) {
    changeIndexValue.value = index;
  }

  generateRandomNumber() {
    var rnd = math.Random();
    var next = rnd.nextDouble() * 100000;
    while (next < 10000) {
      next *= 10;
    }

    qrCodeNumber.value = next.toInt();
    box.write('qrNumber', qrCodeNumber.value);

    getIpLocationDetails();

  }

  void generateQrImage(context) async {
    isProgress = true;
    update();
    final _firebaseStorage = FirebaseStorage.instance;
    final qrValidationResult = QrValidator.validate(
      data: qrCodeNumber.value.toString(),
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode!,
        embeddedImageStyle: null,
        embeddedImage: null,
      );
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      // final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/${qrCodeNumber.value}qr_image.png';
      final picData = await painter.toImageData(2048);
      final buffer = picData!.buffer;
      final file = await File(path).writeAsBytes(
          buffer.asUint8List(picData.offsetInBytes, picData.lengthInBytes));
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${qrCodeNumber.value}qr_image')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      qrImageUrl.value = downloadUrl;
      box.write('imageUrl', qrImageUrl.value);

    }
    createLoginDetails(context);
    // Get.to(()=>PluginPage());

  }

  void getIpLocationDetails() async {
    currentLocationData = await repository.getIpLocationDetails();

    update();
  }

  void createLoginDetails(context) async {

    final data = CreateLoginDetailModel(
        city: currentLocationData.city,
        country: currentLocationData.country,
        ipAddress: currentLocationData.query,
        loginDateTime:
            FirebaseAuth.instance.currentUser!.metadata.lastSignInTime!.toString(),
        pincode: currentLocationData.zip,
        qrNumber: qrCodeNumber.value,
        state: currentLocationData.regionName,
        qrImageUrl: qrImageUrl.value);

    var result = await repository.createLoginDetails(data);
    if(result == 'success'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login details has been saved"),
        backgroundColor: AppConstants.KPRIMARY_COLOR,
      ));
      getLoginDetails();
      isProgress = false;
      update();
    }
    // getLoginDetails();
  }

  void getLoginDetails() async {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

    List<GetLoginDetailsModel> data = await repository.getLoginDetails();
    if (data.isNotEmpty) {
      loginDetailsList.value = await repository.getLoginDetails();
      todayLoginDetailsList.clear();
      yesterdayLoginDetailsList.clear();
      loginDetailsList.forEach((today) {
        if (DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(today.loginDateTime!.toString())) ==
            DateFormat('yyyy-MM-dd').format(now)) {
          todayLoginDetailsList.add(today);
        } else if (DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(today.loginDateTime!)) ==
            DateFormat('yyyy-MM-dd').format(yesterday)) {
          yesterdayLoginDetailsList.add(today);
        }
      });

    }
  }
}
