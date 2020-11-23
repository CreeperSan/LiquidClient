import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTargetDeleteResponse extends BaseNetworkResponseModel {

  NetworkResponseTargetDeleteResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTargetDeleteResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}