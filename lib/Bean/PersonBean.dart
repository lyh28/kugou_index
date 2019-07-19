import 'dart:ui';
import '../Utils/Util.dart';
class PersonBean {
  String image;        //图片
  String label;      //标题
  String nickName;   //主播名字
  final String IMGHEAD="http://p3.fx.kgimg.com";
  //左上角标签
  Tag tag;
  PersonBean(String imagestr,this.label, this.nickName,this.tag){
    if(!imagestr.startsWith("http://")){
      this.image=IMGHEAD+imagestr;
    }else
      this.image=imagestr;
  }


  @override
  String toString() {
    return 'PersonBean{_image: $image, label: $label, _nickName: $nickName, _tag: $tag}';
  }

  static List<PersonBean> getListFromJSON(Map map) {
    List<PersonBean> list = List();
    if (map == null)
      return list;
    List data = map["data"]["list"];
    print('data: $data');
    int len = data.length;
    print('len  $len');
    for (int i = 0; i < len; i++) {
      String title;
      String name="";
      //读取标题等
      if(data[i]["label"]==""||data[i]["label"]==null){
        if(data[i]["introduction"]==null||data[i]["introduction"]==""){
          title=data[i]["nickName"];
        }else
          title=data[i]["introduction"];
      }else{
        title=data[i]["label"];
        name=data[i]["nickName"];
      }
      title=title==null?"":title;
      //读取左上角标签
      List tagList=data[i]["tags"];
      Tag tag=Tag(tagList[0]["tagColor"], tagList[0]["tagName"]);
      PersonBean personBean = PersonBean(
          data[i]["imgPath"], title,name,tag.color==null?null:tag);
      list.add(personBean);
      print('personBean $i  :$personBean');
    }
    return list;
  }
}

class Tag{
  Color color;
  String tagName;
  Tag(String colorstr,this.tagName){
    this.color=Util.getColorFromStr(colorstr);
  }

  @override
  String toString() {
    return 'Tag{_color: $color, _tagName: $tagName}';
  }
}