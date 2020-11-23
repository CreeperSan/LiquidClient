
class UrlUtil{
  static String _baseUrl = 'http://127.0.0.1:4000';

  static void setBaseUrl(String baseUrl){
    _baseUrl = baseUrl;
  }

  static String _accountModule(){
    return '$_baseUrl/api/v1/account';
  }

  static String accountLogin(){
    return '${_accountModule()}/login';
  }

  static String accountRegister(){
    return '${_accountModule()}/register';
  }

  static String accountForget(){
    return '${_accountModule()}/forget';
  }

  static String accountForgetAuth(){
    return '${_accountModule()}/forget_auth';
  }

  static String accountKeyRenew(){
    return '${_accountModule()}/key_renew';
  }

  static String _tagModule(){
    return '$_baseUrl/api/v1/tag';
  }

  static String tagAdd(){
    return '${_tagModule()}/add';
  }

  static String tagList(){
    return '${_tagModule()}/list';
  }

  static String tagDelete(){
    return '${_tagModule()}/delete';
  }

  static String tagUpdate(){
    return '${_tagModule()}/update';
  }

  static String _currencyModule(){
    return '$_baseUrl/api/v1/currency';
  }

  static String currencyList(){
    return '${_currencyModule()}/list';
  }

  static String _recordModule(){
    return '$_baseUrl/api/v1/record';
  }

  static String recordAdd(){
    return '${_recordModule()}/add';
  }

  static String recordUpdate(){
    return '${_recordModule()}/update';
  }

  static String recordDelete(){
    return '${_recordModule()}/delete';
  }

  static String recordList(){
    return '${_recordModule()}/list';
  }

  static String _targetModule(){
    return '$_baseUrl/api/v1/target';
  }

  static String targetList(){
    return '${_targetModule()}/list';
  }

  static String targetAdd(){
    return '${_targetModule()}/add';
  }

  static String targetDelete(){
    return '${_targetModule()}/delete';
  }

  static String targetUpdate(){
    return '${_targetModule()}/update';
  }



}
