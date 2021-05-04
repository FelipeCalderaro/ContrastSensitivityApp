/*
* Operações de integração com WS (API)
*/

import 'dart:convert';

import 'package:adeptus_vision/core/models/graph_model.dart';
import 'package:adeptus_vision/core/models/image_info_model.dart';
import 'package:adeptus_vision/core/services/api.dart';
import 'package:adeptus_vision/ui/values/strings.dart';

class ConstrastSensitivityAPI extends API {
  static ConstrastSensitivityAPI _api = ConstrastSensitivityAPI();
  static ConstrastSensitivityAPI instance() => _api;

  Future<ImageInfoModel> getImage() async {
    try {
      var response = await client.get(Uri.parse('$BASE_URL/getImage'));
      return ImageInfoModel.fromRawJson(response.body);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getTestImageAndInfo(int grating, double contrast) async {
    try {
      var response = await client.get(Uri.parse('$BASE_URL/getTest'), headers: {
        'contrast': contrast.toString(),
        'cycle': grating.toString(),
      });
      if (response.statusCode == 200) {
        return ImageInfoModel.fromRawJson(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> generateGraphAndResults(
      int grating, List<double> values) async {
    try {
      // print(values.toList());
      // print(values.toString());
      // print(values.toSet());
      var response = await client.post(
        Uri.parse('$BASE_URL/calculateResults'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'values': values,
          'cycle': grating,
        }),
      );

      if (response.statusCode == 200) {
        return GraphModel.fromRawJson(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      throw e;
    }
  }
}
