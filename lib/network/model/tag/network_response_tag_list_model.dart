import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTagListResponse extends BaseNetworkResponseModel {

  NetworkResponseTagListResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTagListResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}