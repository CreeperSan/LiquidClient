import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseAccountRenewKeyResponse extends BaseNetworkResponseModel {

  NetworkResponseAccountRenewKeyResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseAccountRenewKeyResponse.networkError() : super.networkError();

  String key = '';

  @override
  decodeData(data) {
    key = data['key'];
  }


}