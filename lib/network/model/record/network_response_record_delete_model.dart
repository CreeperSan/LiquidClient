import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseRecordDeleteResponse extends BaseNetworkResponseModel {

  NetworkResponseRecordDeleteResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseRecordDeleteResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}