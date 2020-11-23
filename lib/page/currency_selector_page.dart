import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/cache/currency_cache.dart';
import 'package:liquid_client/common/model/currency_model.dart';

class CurrencySelectorPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _CurrencySelectorPageState();
  }
  
}

class _CurrencySelectorPageState extends State<CurrencySelectorPage>{
  final List<CurrencyModel> currencyModelList = [];

  @override
  void initState() {
    currencyModelList.clear();
    CurrencyCache.load().then((list){
      currencyModelList.clear();
      currencyModelList.addAll(list);
      setState(() { });
    }).catchError((e){
      print(e);
      currencyModelList.clear();
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('请选择一种货币类型'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 8,
        ),
        child: ListView.separated(
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
        ),
      ),
    );
  }
  
}
