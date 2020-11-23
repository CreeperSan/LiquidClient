import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseRecordUpdateResponse extends BaseNetworkResponseModel {

  NetworkResponseRecordUpdateResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseRecordUpdateResponse.networkError() : super.networkError();

  @override
  decodeData(data) {

  }


}