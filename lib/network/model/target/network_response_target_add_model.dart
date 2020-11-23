import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTargetAddResponse extends BaseNetworkResponseModel {

  NetworkResponseTargetAddResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTargetAddResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}