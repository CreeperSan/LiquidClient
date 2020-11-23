import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseRecordAddResponse extends BaseNetworkResponseModel {

  NetworkResponseRecordAddResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseRecordAddResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}