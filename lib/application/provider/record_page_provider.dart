
import 'package:flutter/cupertino.dart';

class RecordPageProvider extends ChangeNotifier{

  int currentTabIndex = 0;

  setCurrentTabIndex(int index){
    currentTabIndex = index;
    notifyListeners();
  }



}
