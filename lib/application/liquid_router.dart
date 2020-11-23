
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/application/provider/record_page_provider.dart';
import 'package:liquid_client/page/boot_page.dart';
import 'package:liquid_client/page/currency_selector_page.dart';
import 'package:liquid_client/page/login_page.dart';
import 'package:liquid_client/page/record_page.dart';
import 'package:liquid_client/page/tag_selector_page.dart';
import 'package:liquid_client/page/target_add_edit_page.dart';
import 'package:liquid_client/page/target_selector_page.dart';
import 'package:provider/provider.dart';

class LiquidRouter{
  static const Boot = '/boot';
  static const Login = '/login';
  static const Record = '/record';
  static const CurrencySelector = '/currency_selector';
  static const TagSelector = '/tag_selector';
  static const TargetSelector = '/target_selector';
  static const TargetSelectorAddEdit = '/target_selector/add_edit';

  static Map<String, Widget Function(BuildContext)> router = {
    Boot : (BuildContext context){
      return BootPage();
    },
    Login : (BuildContext context){
      return LoginPage();
    },
    Record : (BuildContext context){
      return ChangeNotifierProvider<RecordPageProvider>.value(
        value: RecordPageProvider(),
        child: RecordPage(),
      );
    },
    CurrencySelector : (BuildContext context){
      return CurrencySelectorPage();
    },
    TagSelector : (BuildContext context){
      return TagSelectorPage();
    },
    TargetSelector : (BuildContext context){
      return TargetSelectorPage();
    },
    TargetSelectorAddEdit : (BuildContext context){
      return TargetAddEditPage();
    },
  };

}
