import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grootan/model/login_details_model.dart';
import 'package:grootan/model/location_details_model.dart';
import 'package:http/http.dart' as http; //for making request

class LocationDetailsProvider {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<GetIpLocation> getIpLocationDetails({required String url}) async {
    var urlData = Uri.http(url, 'json');

    final response = await http.get(urlData);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return GetIpLocation.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<String> createLoginDetails(CreateLoginDetailModel data) async{
    String returnData = 'failure';
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await db
        .collection("login_details_collection")
        .doc(userId)
        .collection("details")
        .add(data.toJson()).then((value){
          print(value.id);
          returnData = 'success';
    });
    return returnData;
  }

  Future<List<GetLoginDetailsModel>> getLoginDetails() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final response = await db
        .collection("login_details_collection")
        .doc(userId)
        .collection("details")
        .get();
    List<GetLoginDetailsModel> data = response.docs
        .map((e) => GetLoginDetailsModel.fromJson(e.data()))
        .toList();
    return data;
  }
}
