class PushLineBean{
  String image;
  String subTitle;
  String title;

  PushLineBean(this.image, this.subTitle, this.title);

  @override
  String toString() {
    return 'PushLineBean{image: $image, subTitle: $subTitle, title: $title}';
  }

  static List<PushLineBean> getListFromJSON(Map map) {
    List<PushLineBean> list = List();
    if (map == null)
      return list;
    List data = map["data"];
    int len = data.length;
    for (int i = 0; i < len; i++) {
      PushLineBean pushLineBean = PushLineBean(
          data[i]["image"], data[i]["subTitle"], data[i]["title"]);
      list.add(pushLineBean);
     // print("PushLine  " + i.toString() + "  :" + pushLineBean.toString());
    }
    return list;
  }
}