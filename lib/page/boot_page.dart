import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/liquid_router.dart';
import 'package:liquid_client/network/model/account/network_response_account_renew_key_model.dart';
import 'package:liquid_client/network/network_manager.dart';
import 'package:liquid_client/page/login_page.dart';
import 'package:liquid_client/storage/kv_keys.dart';
import 'package:liquid_client/storage/kv_storage_manager.dart';
import 'package:liquid_client/toast/toast_manager.dart';

class BootPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _BootPageState();
  }

}

class _BootPageState extends State<BootPage>{

  @override
  void initState() {
    super.initState();

    initData();

  }

  void initData() async {

    String key = await KVStorageManager.getString(KVKey.AccountKey);
    int userID = await KVStorageManager.getInt(KVKey.AccountUserID);

    NetworkManager.setKey(key);
    NetworkManager.setID(userID);

    if(key != '' && userID != 0){
      NetworkResponseAccountRenewKeyResponse response = await NetworkManager.accountRenewKey(key);
      if(response.isSuccess()){
        ToastManager.show('登录成功');
        toRecordPage();
      } else {
        ToastManager.show(response.message);
        toLoginPage();
      }
    } else {
      toLoginPage();
    }

  }

  void toLoginPage(){
    Future.delayed(Duration(
        seconds: 0
    ), (){
      Navigator.of(context).pushReplacementNamed(LiquidRouter.Login);
    });
  }

  void toRecordPage(){
    Navigator.of(context).pushReplacementNamed(LiquidRouter.Record);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text('Logo Here'),
      ),
    );
  }

}
