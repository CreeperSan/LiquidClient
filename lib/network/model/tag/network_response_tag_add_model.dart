import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTagAddResponse extends BaseNetworkResponseModel {

  NetworkResponseTagAddResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTagAddResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}