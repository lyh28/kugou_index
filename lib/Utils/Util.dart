import 'dart:ui';
class Util{
  static Color getColorFromStr(String str){
    if(str=="") return null;
    return Color(int.parse(str.substring(1),radix: 16));
  }
}