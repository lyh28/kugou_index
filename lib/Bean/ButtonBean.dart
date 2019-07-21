import 'dart:ui';
class ButtonBean {
  String bgImg;        //图片
  String moduleName;      //标题
  String subTitle;   //主播名字
  ButtonBean(this.bgImg,this.moduleName, this.subTitle);

  @override
  String toString() {
    return 'ButtonBean{bgImg: $bgImg, moduleName: $moduleName, subTitle: $subTitle}';
  }

  static List<ButtonBean> getListFromJSON(Map map) {
    List<ButtonBean> list = List();
    if (map == null)
      return list;
    List data = map["data"];
    print('data: $data');
    int len = data.length;
    print('len  $len');
    for (int i = 0; i < len; i++) {
      //读取左上角标签
      ButtonBean buttonBean = ButtonBean(
          data[i]["bgImg"],data[i]["moduleName"],data[i]["subTitle"]);
      list.add(buttonBean);
      print('personBean $i  :$buttonBean');
    }
    return list;
  }
}