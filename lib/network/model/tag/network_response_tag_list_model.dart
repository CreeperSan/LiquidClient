import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/model/tag_model.dart';
import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTagListResponse extends BaseNetworkResponseModel {
  List<TagModel> tagModelList = [];

  NetworkResponseTagListResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTagListResponse.networkError() : super.networkError();

  @override
  decodeData(data) {
    tagModelList.clear();
    for(dynamic tagJson in data){
      try {
        TagModel tagModel = new TagModel.single(
                id: tagJson['id'],
                color: Color(0xFF66CCFF),
                name: tagJson['name'],
        );
        tagModelList.add(tagModel);
      } catch (e) {
        print(e);
      }
    }
  }


}