import 'dart:ui';
class Util{
  static Color getARGBColorFromStr(String str){
    if(str=="") return null;
    return Color(int.parse(str.substring(1),radix: 16));
  }
  static Color getRGBColorFromStr(String str){
    if(str=="") return null;
    return Color(int.parse(str.substring(1),radix: 16)+0xFF000000);
  }
}