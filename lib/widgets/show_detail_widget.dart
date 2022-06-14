// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grootan/model/login_details_model.dart';
import 'package:grootan/utils/constants.dart';
import 'package:intl/intl.dart';

class ShowDetails extends StatelessWidget {
  final List<GetLoginDetailsModel> loginDetailsList;

  const ShowDetails({Key? key, required this.loginDetailsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return loginDetailsList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'No login found at this day!',
                  style: TextStyle(
                      color: Colors.white, fontSize: AppConstants.KMEDIUM_FONT),
                ),
              )
            ],
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 25),
            itemCount: loginDetailsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: size.width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppConstants.KCENTER_DESIGN_COLOR,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('hh:mm a').format(DateTime.parse(
                              loginDetailsList[index].loginDateTime!)),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'IP: ${loginDetailsList[index].ipAddress ?? 'Not Found'}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${loginDetailsList[index].city ?? 'Not found'}'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: 10,
                    child: loginDetailsList[index].qrImageUrl != null &&
                            loginDetailsList[index].qrImageUrl != ''
                        ? Container(
                            // width: 70,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: NetworkImage(
                                    '${loginDetailsList[index].qrImageUrl}'),
                                height: 70,
                                width: 70,
                              ),
                            ),
                          )
                        : SizedBox(),
                  )
                ],
              );
            });
  }
}
