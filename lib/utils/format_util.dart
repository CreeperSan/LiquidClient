
class FormatUtil{
  
  static bool isEmpty(dynamic value){
    if(value == null){
      return true;
    }
    if(value is List){
      return value.isEmpty;
    }
    if(value is String){
      return value.isEmpty;
    }
    if(value is Map){
      return value.entries.isEmpty;
    }
    return false;
  }
  
}
