import 'dart:convert';

import 'package:aeqarat/src/models/profile_response_model.dart';
import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/models/real_estate_update_response_model.dart'
    as RealEstateUpdateResponseModel;
import 'package:aeqarat/src/utils/networking/app_url.dart';
import 'package:aeqarat/src/utils/networking/real_estate_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

enum RealEstateUpdateLoading {
  Loading,
  Succeed,
  Failed,
}

class RealEstateUpdateApi with ChangeNotifier {
  RealEstateUpdateLoading _loadingStatus;

  RealEstateUpdateLoading get loadingStatus => _loadingStatus;

  Future<Map<String, dynamic>> updateRealEstate(
      String apiToken,
      String realEstateId,
      ProfileResponseModel user,
      RealEstateResponseModel realEstate,
      String startDate,
      String requestDate,
      int duration,
      int paymentMethod) async {
    var result;

    _loadingStatus = RealEstateUpdateLoading.Loading;
    notifyListeners();

    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiToken',
      'Content-type': "multipart/form-data"
    };

    List<Requests> requests = [];

    await RealEstateApi().loadRealEstate(realEstateId).then((result) {
      RealEstateResponseModel realEstate = result['data'];
        for (Requests request in realEstate.requests) {
          requests.add(request);
        }
    });

    requests.add(Requests(
        userId: user.sId,
        username: user.username,
        email: user.email,
        phoneNumber: user.phoneNumber,
        amount: realEstate.price,
        insuranceAmount: realEstate.insuranceAmount,
        startDate: startDate,
        requestDate: requestDate,
        duration: duration,
        paymentMethod: paymentMethod,
        realEstateStatus: realEstate.status,
        status: 0));

    final Map<String, String> requestBody = {
      "data": json.encode({'requests': requests}).toString()
    };

    var request;

    try {
      request = MultipartRequest(
          'PUT', Uri.parse(AppUrl.real_estates_url + realEstateId))
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
    } on Exception catch (e) {
      e.toString();
      _loadingStatus = RealEstateUpdateLoading.Failed;
      notifyListeners();
    }

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      RealEstateUpdateResponseModel.RealEstateUpdateResponseModel
          realEstateUpdateResponseModel =
          RealEstateUpdateResponseModel.RealEstateUpdateResponseModel.fromJson(
              responseData);

      _loadingStatus = RealEstateUpdateLoading.Succeed;
      notifyListeners();

      result = {'status': true, 'data': realEstateUpdateResponseModel};
    } else {
      _loadingStatus = RealEstateUpdateLoading.Failed;
      notifyListeners();

      result = {'status': true, 'data': responseData};
    }
    return result;
  }
}
