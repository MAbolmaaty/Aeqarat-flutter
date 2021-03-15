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
  RealEstateResponseModel _realEstateResponseModel;

  RealEstateLoading get loadingStatus => _loadingStatus;
  RealEstateResponseModel get realEstate => _realEstateResponseModel;

  Future<Map<String, dynamic>> loadRealEstate(String realEstateId) async {
    var result;

    _loadingStatus = RealEstateLoading.Loading;
    notifyListeners();

    Response response;
    try {
      response = await get(
        Uri.parse(AppUrl.real_estates_url + realEstateId),
      );
    } on Exception catch (e) {
      e.toString();
    }

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _realEstateResponseModel =
          RealEstateResponseModel.fromJson(responseData);
      _loadingStatus = RealEstateLoading.Succeed;
      notifyListeners();
      result = {'status': true, 'data': _realEstateResponseModel};
    } else {
      _loadingStatus = RealEstateLoading.Failed;
      notifyListeners();

      result = {'status': false, 'data': responseData};
    }

    return result;
  }
}
