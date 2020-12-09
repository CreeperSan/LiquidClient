

import 'package:flutter/cupertino.dart';

class CupertinoLoadingDialog extends StatefulWidget{
  _CupertinoLoadingDialogState state;

  String message;

  CupertinoLoadingDialog({
    this.message = '加载中'
  });

  @override
  State<StatefulWidget> createState() {
    state = _CupertinoLoadingDialogState();
    return state;
  }

  void close({dynamic data}){
    state?.close(
      data: data
    );
  }

}

class _CupertinoLoadingDialogState extends State<CupertinoLoadingDialog>{
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return CupertinoAlertDialog(
      content: Column(
        children: [
          CupertinoActivityIndicator(),
          Padding(
            padding: EdgeInsets.only(
              top: 22,
            ),
            child: Text('正在删除对象'),
          )
        ],
      ),
    );
  }

  void close({dynamic data}){
    if(_context == null){
      return;
    }
    Navigator.pop(_context, data);
  }

}
