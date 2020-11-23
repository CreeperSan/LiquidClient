
import 'package:flutter/cupertino.dart';

class TagSelectorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _TagSelectorPageState();
  }

}

class _TagSelectorPageState extends State<TagSelectorPage>{

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('请选择标签'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
        ),
        child: Text('标签选择器'),
      ),
    );
  }

}
