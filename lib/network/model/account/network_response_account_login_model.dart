
import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseAccountLoginModel extends BaseNetworkResponseModel {
  int userID = 0;
  String key = '';

  NetworkResponseAccountLoginModel.fromJson(dynamic jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseAccountLoginModel.networkError() : super.networkError();


  @override
  decodeData(data) {
    userID = data['id'];
    key = data['key'];
  }

}