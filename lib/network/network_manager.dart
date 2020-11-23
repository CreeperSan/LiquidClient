
import 'package:dio/dio.dart';
import 'package:liquid_client/network/model/account/network_response_account_login_model.dart';
import 'package:liquid_client/network/model/account/network_response_account_renew_key_model.dart';
import 'package:liquid_client/network/model/base_network_response_model.dart';
import 'package:liquid_client/network/model/target/network_response_target_list_model.dart';
import 'package:liquid_client/network/url_util/url_util.dart';

import 'model/currency/network_response_currency_list_model.dart';
import 'model/record/network_response_record_add_model.dart';
import 'model/record/network_response_record_delete_model.dart';
import 'model/record/network_response_record_list_model.dart';
import 'model/record/network_response_record_update_model.dart';
import 'model/tag/network_response_tag_add_model.dart';
import 'model/tag/network_response_tag_delete_model.dart';
import 'model/tag/network_response_tag_list_model.dart';
import 'model/tag/network_response_tag_update_model.dart';
import 'model/target/network_response_target_add_model.dart';
import 'model/target/network_response_target_delete_model.dart';
import 'model/target/network_response_target_update_model.dart';

class NetworkManager{
  static Dio _dio;
  static String _key = '';
  static int _id = 0;

  static void setKey(String key){
    _key = key;
  }

  static void setID(int id){
    _id = id;
  }
  
  static Dio _getDio(){
    if(_dio == null){
      _dio = Dio();
    }
    _dio.options.headers['key'] = _key;
    return _dio;
  }

  //////////////////////////////////////////////////////////////////////////////

  /// 账号登录
  /// [account] 账号
  /// [password] 密码
  static Future<NetworkResponseAccountLoginModel> accountLogin(String account, String password) async {
    try {
      dynamic response = await _getDio().post(UrlUtil.accountLogin(),
        data: {
          'account' : account,
          'password' : password,
        }
      );
      return NetworkResponseAccountLoginModel.fromJson(response);
    } catch (e) {
      print(e);
      return NetworkResponseAccountLoginModel.networkError();
    }
  }

  /// 账号Key续约
  /// [key] 账号的身份Key
  static Future<NetworkResponseAccountRenewKeyResponse> accountRenewKey(String key) async {
    try {
      dynamic response = await _getDio().post(UrlUtil.accountKeyRenew(),);
      return NetworkResponseAccountRenewKeyResponse.fromJson(response);
    } catch (e) {
      print(e);
      return NetworkResponseAccountRenewKeyResponse.networkError();
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  /// 获取支持的所有货币列表
  static Future<NetworkResponseCurrencyListModel> currencyGetList() async {
    try{
      dynamic response = await _getDio().post(UrlUtil.currencyList());
      return NetworkResponseCurrencyListModel.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseCurrencyListModel.networkError();
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  /// 获取所有流水的对象
  static Future<NetworkResponseTargetListResponse> targetGetList() async {
    try{
      dynamic response = await _getDio().post(UrlUtil.targetList());
      return NetworkResponseTargetListResponse.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseTargetListResponse.networkError();
    }
  }

  /// 添加流水对象
  static Future<NetworkResponseTargetAddResponse> targetAdd(String name) async {
    try {
      dynamic response = await _getDio().post(UrlUtil.targetAdd(),
            data: {
              'name' : name,
            }
          );
      return NetworkResponseTargetAddResponse.fromJson(response);
    } catch (e) {
      print(e);
      return NetworkResponseTargetAddResponse.networkError();
    }

  }

  /// 删除流水对象
  static Future<NetworkResponseTargetDeleteResponse> targetDelete(int targetID) async {
    try{
      dynamic response = await _getDio().post(UrlUtil.targetDelete(),
        data: {
          'target_id' : targetID,
        }
      );
      return NetworkResponseTargetDeleteResponse.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseTargetDeleteResponse.networkError();
    }
  }

  /// 更新流水对象
  static Future<NetworkResponseTargetUpdateResponse> targetUpdate() async {

  }

  //////////////////////////////////////////////////////////////////////////////

  /// 获取所有流水的标签
  static Future<NetworkResponseTagListResponse> tagGetList() async {
    try{
      dynamic response = await _getDio().post(UrlUtil.tagList());
      return NetworkResponseTagListResponse.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseTagListResponse.networkError();
    }
  }

  /// 添加流水标签
  static Future<NetworkResponseTagAddResponse> tagAdd() async {

  }

  /// 删除流水标签
  static Future<NetworkResponseTagDeleteResponse> tagDelete(int tagID) async {
    try{
      dynamic response = await _getDio().post(UrlUtil.tagDelete(),
          data: {
            'tag_id' : tagID,
          }
      );
      return NetworkResponseTagDeleteResponse.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseTagDeleteResponse.networkError();
    }
  }

  /// 更新流水标签
  static Future<NetworkResponseTagUpdateResponse> tagUpdate() async {

  }

  //////////////////////////////////////////////////////////////////////////////

  /// 获取指定条件的流水记录
  static Future<NetworkResponseRecordListResponse> recordGetList() async {
    try{
      dynamic response = await _getDio().post(UrlUtil.recordList());
      return NetworkResponseRecordListResponse.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseRecordListResponse.networkError();
    }
  }

  /// 添加流水记录
  static Future<NetworkResponseRecordAddResponse> recordAdd() async {

  }

  /// 删除流水记录
  static Future<NetworkResponseRecordDeleteResponse> recordDelete(int recordID) async {
    try{
      dynamic response = await _getDio().post(UrlUtil.recordDelete(),
          data: {
            'record_id' : recordID,
          }
      );
      return NetworkResponseRecordDeleteResponse.fromJson(response);
    }catch(e){
      print(e);
      return NetworkResponseRecordDeleteResponse.networkError();
    }
  }

  /// 更新流水记录
  static Future<NetworkResponseRecordUpdateResponse> recordUpdate() async {

  }

}
