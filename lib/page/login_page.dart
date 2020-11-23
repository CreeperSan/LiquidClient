import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_client/application/liquid_router.dart';
import 'package:liquid_client/network/model/account/network_response_account_login_model.dart';
import 'package:liquid_client/network/network_manager.dart';
import 'package:liquid_client/storage/kv_keys.dart';
import 'package:liquid_client/storage/kv_storage_manager.dart';
import 'package:liquid_client/toast/toast_manager.dart';
import 'package:liquid_client/utils/format_util.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage> {
  TextEditingController accountEditFieldController;
  TextEditingController passwordEditFieldController;

  @override
  void initState() {
    super.initState();
    accountEditFieldController = TextEditingController(text: '14412345678');
    passwordEditFieldController = TextEditingController(text: 'Aa888888');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: Center(
          child: SizedBox(
            width: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Liquid',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                CupertinoTextField(
                  controller: accountEditFieldController,
                ),
                CupertinoTextField(
                  controller: passwordEditFieldController,
                ),
                CupertinoButton(
                  child: Text('登录'),
                  onPressed: _onLoginPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() async {
    String account = accountEditFieldController.text;
    String password = passwordEditFieldController.text;

    if(FormatUtil.isEmpty(account)){
      ToastManager.show('账号不能为空');
      return;
    }

    if(FormatUtil.isEmpty(password)){
      ToastManager.show('密码不能为空');
      return;
    }

    NetworkResponseAccountLoginModel loginResponseModel = await NetworkManager.accountLogin(account, password);
    if(loginResponseModel.isSuccess()){
      int userID = loginResponseModel.userID;
      String key = loginResponseModel.key;
      NetworkManager.setID(userID);
      NetworkManager.setKey(key);
      KVStorageManager.setInt(KVKey.AccountUserID, userID);
      KVStorageManager.setString(KVKey.AccountKey, key);
      Navigator.of(context).pushReplacementNamed(LiquidRouter.Record);
    } else {
      ToastManager.show(loginResponseModel.message);
    }

  }

}
