import 'dart:convert';

import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/utils/networking/app_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

enum RealEstateLoading {
  Loading,
  Succeed,
  Failed,
}

class RealEstateApi with ChangeNotifier {
  RealEstateLoading _loadingStatus;

  RealEstateLoading get loadingStatus => _loadingStatus;

  Future<Map<String, dynamic>> realEstate(String realEstateId) async {
    var result;

    _loadingStatus = RealEstateLoading.Loading;
    notifyListeners();

    Response response;
    try {
      response = await get(
        Uri.parse(AppUrl.real_estates_url + realEstateId),
      );
    } on Exception catch (e) {
      _loadingStatus = RealEstateLoading.Failed;
      notifyListeners();
    }

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _loadingStatus = RealEstateLoading.Succeed;
      notifyListeners();

      RealEstateResponseModel realEstateResponseModel =
          RealEstateResponseModel.fromJson(responseData);
      result = {'status': true, 'data': realEstateResponseModel};
    } else {
      _loadingStatus = RealEstateLoading.Failed;
      notifyListeners();

      result = {'status': false, 'data': responseData};
    }

    return result;
  }
}
