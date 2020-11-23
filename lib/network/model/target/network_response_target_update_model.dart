import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTargetUpdateResponse extends BaseNetworkResponseModel {

  NetworkResponseTargetUpdateResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTargetUpdateResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}