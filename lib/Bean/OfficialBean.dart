import 'package:kugou_index/Utils/Util.dart';
import 'dart:ui';

class OfficialBean {
  String coverPath;
  String subTitle;
  Color tagColor;
  String tagName;
  String title;

  OfficialBean(
      this.coverPath, this.subTitle, this.tagColor, this.tagName, this.title);

  @override
  String toString() {
    return 'OfficialBean{coverPath: $coverPath, subTitle: $subTitle, tagColor: $tagColor, tagName: $tagName, title: $title}';
  }

  static List<OfficialBean> getListFromJSON(Map map) {
    List<OfficialBean> list=new List();
    if(map==null) {return list;}
    List data=map["data"]["list"];
    int len=data.length;

    for(int i=0;i<len;i++){
      OfficialBean officialBean=OfficialBean(data[i]["coverPath"], data[i]["subTitle"], Util.getRGBColorFromStr(data[i]["tagColor"]), data[i]["tagName"], data[i]["title"]);
      list.add(officialBean);
      //print('officialBean $i  :$officialBean');
    }
    return list;
  }
}
