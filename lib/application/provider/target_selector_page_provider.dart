
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/page/target_selector_page.dart';

class TargetSelectorPageProvider extends ChangeNotifier {
  TargetSelectorPageType pageType = TargetSelectorPageType.Select;

  setPageType(TargetSelectorPageType pageType){
    this.pageType = pageType;
    notifyListeners();
  }


}

enum TargetSelectorPageType{
  Edit,
  Select,
  List,
}
