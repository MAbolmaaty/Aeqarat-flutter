import 'dart:convert';

import 'package:aeqarat/src/models/real_estates_response_model.dart';
import 'package:aeqarat/src/utils/networking/app_url.dart';
import 'package:http/http.dart';

class RealEstatesApi{

  Future<List<RealEstatesResponseModel>> getRealEstates() async{
    List<RealEstatesResponseModel> realEstates;

    Response response = await get(Uri.parse(AppUrl.real_estates_url));

    if(response.statusCode == 200) {
      var responseData = await json.decode(response.body) as List;
      realEstates = responseData.map((realEstatesResponseModel) =>
      RealEstatesResponseModel.fromJson(realEstatesResponseModel)).toList();
    }

    return realEstates;
  }
}