import 'dart:convert';

class BaseNetworkResponseModel{
  static const int CODE_SUCCESS = 200;
  static const int CODE_NETWORK_ERROR = -1;
  static const int CODE_DECODE_ERROR = -2;

  int code = 0;
  String message = '';

  BaseNetworkResponseModel.fromJson(dynamic jsonResponse){
    try {
      print(jsonResponse.data);
      dynamic response = jsonDecode(jsonResponse.data.toString());
      code = response['code'];
      message = response['message'];
      decodeData(response['data']);
    } catch (e) {
      print(e);
      code = CODE_DECODE_ERROR;
      message = '数据解析失败，请稍后重试';
    }
  }

  BaseNetworkResponseModel.networkError({
    String message = '网络连接失败，请检查您的网络连接'
  }){
    code = CODE_NETWORK_ERROR;
    message = message;
  }

  decodeData(dynamic data){
  }

  bool isSuccess(){
    return code == 200;
  }

}