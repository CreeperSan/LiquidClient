
import 'package:flutter/cupertino.dart';

class CupertinoStringPicker extends StatefulWidget{
  double itemHeight;
  Widget Function(int index) itemBuilder;
  void Function(int index) onSelectItemChange;
  int itemCount;
  int defaultPosition;
  double width;
  double height;

  CupertinoStringPicker({
    this.itemHeight = 50,
    @required this.itemBuilder,
    @required this.itemCount,
    this.defaultPosition = 0,
    this.width = 64,
    this.height = 300,
    this.onSelectItemChange,
  });


  @override
  State<StatefulWidget> createState() {
    return CupertinoStringPickerState();
  }

}

class CupertinoStringPickerState<T> extends State<CupertinoStringPicker>{
  List<Widget> widgetList = [];
  FixedExtentScrollController scrollerController;

  @override
  void initState() {
    super.initState();
    // Widget Item
    widgetList.clear();
    for(int i=0; i<widget.itemCount; i++){
      widgetList.add(widget.itemBuilder(i));
    }
    // 滚动监听
    scrollerController = FixedExtentScrollController(
      initialItem: widget.defaultPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CupertinoPicker(
        itemExtent: widget.itemHeight,
        children: widgetList,
        scrollController: scrollerController,
        onSelectedItemChanged: (index){
          if(widget.onSelectItemChange != null){
            widget.onSelectItemChange(index);
          }
        },
      ),
    );
  }

}

