import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTagDeleteResponse extends BaseNetworkResponseModel {

  NetworkResponseTagDeleteResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTagDeleteResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}