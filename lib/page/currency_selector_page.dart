import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/provider/liquid_provider.dart';
import 'package:liquid_client/cache/currency_cache.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/currency_model.dart';
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
      child: Padding(
        padding: EdgeInsets.only(
          top: 42,
        ),
        child: Selector<LiquidProvider, NetworkRequestState>(
          builder: buildContentPage,
          selector: (buildContext, provider){
            return provider.currencyRequestState;
          },
        ),
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
    return Text('可以下拉刷新加载');
  }

  Widget buildLoadingPage(){
    return Text('加载中');
  }

  Widget buildLoadFailPage(){
    return Text('加载失败');
  }

  Widget buildLoadSuccessPage(){
    List<CurrencyModel> currencyModelList = context.read<LiquidProvider>().currencyModelList;
    return ListView.separated(
      itemBuilder: (listViewContext, index){
        CurrencyModel currencyModel = currencyModelList[index];
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('${currencyModel.shortName} - ${currencyModel.region} - ${currencyModel.name}'),
          ],
        );
      },
      separatorBuilder: (listViewContext, index){
        return Divider();
      },
      itemCount: currencyModelList.length,
    );
  }
  
}
