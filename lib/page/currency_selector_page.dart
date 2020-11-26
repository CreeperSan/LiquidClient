import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/provider/liquid_provider.dart';
import 'package:liquid_client/cache/currency_cache.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/utils/format_util.dart';
import 'package:provider/provider.dart';

class CurrencySelectorPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _CurrencySelectorPageState();
  }
  
}

class _CurrencySelectorPageState extends State<CurrencySelectorPage>{

  @override
  void initState() {
    context.read<LiquidProvider>().loadCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('请选择一种货币类型'),
      ),
      child: Selector<LiquidProvider, NetworkRequestState>(
        builder: buildContentPage,
        selector: (buildContext, provider){
          return provider.currencyRequestState;
        },
      ),
    );
  }

  Widget buildContentPage(BuildContext context, NetworkRequestState state, Widget widget){
    print('buildContentPage($state)');
    switch(state){
      case NetworkRequestState.Idle:
        return buildLoadIdlePage();
      case NetworkRequestState.Success:
        return buildLoadSuccessPage();
      case NetworkRequestState.Fail:
        return buildLoadFailPage();
      case NetworkRequestState.Loading:
        return buildLoadingPage();
      default:
        return buildLoadIdlePage();
    }
  }

  Widget buildLoadIdlePage(){
    return SafeArea(
      child: Text('可以下拉刷新加载'),
    );
  }

  Widget buildLoadingPage(){
    return SafeArea(
      child: Text('加载中'),
    );
  }

  Widget buildLoadFailPage(){
    return SafeArea(
      child: Text('加载失败'),
    );
  }

  Widget buildLoadSuccessPage(){
    List<CurrencyModel> currencyModelList = context.read<LiquidProvider>().currencyModelList;
    return ListView.separated(
      itemBuilder: (listViewContext, index){
        CurrencyModel currencyModel = currencyModelList[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 16
                  ),
                  child: Image(
                    image: AssetImage(FormatUtil.currencyShortNameToEmojiFlag(currencyModel.shortName)),
                    width: 24,
                    fit: BoxFit.cover,
                  ),
                ),
                Text('${currencyModel.region} - ${currencyModel.name} ( ${currencyModel.shortName} )'),
              ],
            ),
          ),
          onTap: (){ _onCurrencyClick(currencyModel, index); },
        );
      },
      separatorBuilder: (listViewContext, index){
        return Divider(
          height: 0.5,
          thickness: 0.5,
        );
      },
      itemCount: currencyModelList.length,
    );
  }

  void _onCurrencyClick(CurrencyModel currencyModel, int index){
    print('选择了 $currencyModel');
    Navigator.pop(context, {
      'isSuccess' : true,
      'result' : currencyModel,
    });
  }

}
