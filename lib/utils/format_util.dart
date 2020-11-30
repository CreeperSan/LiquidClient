
import 'package:liquid_client/const/image_flag.dart';

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

  static String timestampToRecordTime(int timeStamp){
    var time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return '${time.year}年${time.month}月${time.day}日 ${time.hour}时${time.minute}分${time.second}秒';
  }

  static String currencyShortNameToEmojiFlag(String currencyShortName){
    switch(currencyShortName){
      case 'AED' : return ImageFlag.AED;
      case 'ARS' : return ImageFlag.ARS;
      case 'AUD' : return ImageFlag.AUD;
      case 'BGN' : return ImageFlag.BGN;
      case 'BRL' : return ImageFlag.BRL;
      case 'BSD' : return ImageFlag.BSD;
      case 'CAD' : return ImageFlag.CAD;
      case 'CHF' : return ImageFlag.CHF;
      case 'CLP' : return ImageFlag.CLP;
      case 'CNY' : return ImageFlag.CNY;
      case 'COP' : return ImageFlag.COP;
      case 'CZK' : return ImageFlag.CZK;
      case 'DKK' : return ImageFlag.DKK;
//      case 'DOP' : return '';
      case 'EGP' : return ImageFlag.EGP;
      case 'EUR' : return ImageFlag.EUR;
      case 'FJD' : return ImageFlag.FJD;
      case 'GBP' : return ImageFlag.GBP;
      case 'GTP' : return ImageFlag.GTQ;
      case 'HKD' : return ImageFlag.HKD;
      case 'HRK' : return ImageFlag.HRK;
      case 'HUF' : return ImageFlag.HUF;
      case 'IDR' : return ImageFlag.IDR;
      case 'ILS' : return ImageFlag.ILS;
      case 'IND' : return ImageFlag.INR;
      case 'ISK' : return ImageFlag.ISK;
      case 'JPY' : return ImageFlag.JPY;
      case 'KRW' : return ImageFlag.KRW;
      case 'KZT' : return ImageFlag.KZT;
      case 'MOP' : return ImageFlag.MOP;
      case 'MVR' : return ImageFlag.MVR;
      case 'MXN' : return ImageFlag.MXN;
      case 'MYR' : return ImageFlag.MYR;
      case 'NOK' : return ImageFlag.NOK;
      case 'NZD' : return ImageFlag.NZD;
      case 'PAB' : return ImageFlag.PAB;
      case 'PEN' : return ImageFlag.PEN;
      case 'PHP' : return ImageFlag.PHP;
      case 'PRK' : return ImageFlag.PKR;
      case 'PLN' : return ImageFlag.PLN;
//      case 'PYG' : return '';
      case 'RON' : return ImageFlag.RON;
      case 'RUB' : return ImageFlag.RUB;
      case 'SAR' : return ImageFlag.SAR;
      case 'SEK' : return ImageFlag.SEK;
      case 'SGD' : return ImageFlag.SGD;
      case 'THB' : return ImageFlag.THB;
      case 'TRY' : return ImageFlag.TRY;
      case 'TWD' : return ImageFlag.TWD;
      case 'UAH' : return ImageFlag.UAH;
      case 'USD' : return ImageFlag.USD;
      case 'UYU' : return ImageFlag.UYU;
      case 'ZAR' : return ImageFlag.ZAR;
    }
    return ImageFlag.EMPTY;
  }
  
}
