

import 'package:grootan/model/login_details_model.dart';
import 'package:grootan/model/location_details_model.dart';
import 'package:grootan/provider/location_details_provider.dart';
import 'package:grootan/utils/api_constants.dart';

class LocationDetailsRepository{
  LocationDetailsProvider provider = LocationDetailsProvider();

  Future<GetIpLocation> getIpLocationDetails() async{
    GetIpLocation ipLocationData = await provider.getIpLocationDetails(url: ApiConstants.ipLocationUrl);
    return ipLocationData;
  }

  Future<String> createLoginDetails(CreateLoginDetailModel data) async{
    return await provider.createLoginDetails(data);
  }

  Future<List<GetLoginDetailsModel>> getLoginDetails()async{
    List<GetLoginDetailsModel> data  = await provider.getLoginDetails();
    return data;
  }

}