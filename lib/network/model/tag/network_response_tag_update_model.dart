import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTagUpdateResponse extends BaseNetworkResponseModel {

  NetworkResponseTagUpdateResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTagUpdateResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}