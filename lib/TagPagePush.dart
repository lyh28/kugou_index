import 'dart:async';
import 'Bean/PushLineBean.dart';
import 'Bean/PersonBean.dart';
import 'Bean/ButtonBean.dart';
import 'Bean/OfficialBean.dart';
import 'Requset/KuGouRequest.dart';
import 'package:flutter/material.dart';

//推荐页
class TabPagePush extends StatefulWidget {
  TabPagePush({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabPagePushState();
  }
}

class TabPagePushState extends State<TabPagePush> {
  void update() {
    Beans.initPerson();
    Beans.initPushLine();
    Beans.initButton();
    Beans.initOfficial();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("初始化");
    update();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: createIcon(
                      Beans.buttonList[0].bgImg,
                      Beans.buttonList[0].moduleName,
                      Beans.buttonList[0].subTitle)),
              Expanded(
                  child: createIcon(
                      Beans.buttonList[1].bgImg,
                      Beans.buttonList[1].moduleName,
                      Beans.buttonList[1].subTitle)),
              Expanded(
                  child: createIcon(
                      Beans.buttonList[2].bgImg,
                      Beans.buttonList[2].moduleName,
                      Beans.buttonList[2].subTitle))
            ],
          ),
          //四格推荐
          PushFours(),
          //官方推荐
          OfficialPushs(),
          //推送条
          PushLine(),
          //更多推荐
          PushFours(),
          PushFours(),
        ],
      ),
    );
  }

  //生成三个小按钮
  Padding createIcon(String icon, String top, String bottom) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: FadeInImage.assetNetwork(
            placeholder: "images/icon1.png",
            image: icon,
            width: 35,
            height: 35,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(top,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text(bottom, style: TextStyle(fontSize: 10))
          ],
        )
      ])),
    );
  }
}

//首页推荐  四格
class PushFours extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(Beans.personindex+4>=Beans.personBeanList.length)
      return null;
    Beans.personindex+=4;
    return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        childAspectRatio: 0.88,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        children: <Widget>[
          PushIndex(Beans.personBeanList[Beans.personindex-4]),
          PushIndex(Beans.personBeanList[Beans.personindex-3]),
          PushIndex(Beans.personBeanList[Beans.personindex-2]),
          PushIndex(Beans.personBeanList[Beans.personindex-1]),
        ]);
  }
}

class PushIndex extends StatelessWidget {
  PushIndex(@required this.personBean, {Key key}) : super(key: key);
  PersonBean personBean;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topLeft,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: "images/default.png",
              image: personBean.image,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            Container(
              child: Container(
                decoration: BoxDecoration(
                    color:
                        personBean.tag == null ? null : personBean.tag.color),
                child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                        personBean.tag == null ? "" : personBean.tag.tagName,
                        style: TextStyle(color: Colors.white, fontSize: 10))),
              ),
            )
          ],
        )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Text(personBean.label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800))),
        Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(personBean.nickName, style: TextStyle(fontSize: 10))),
      ],
    );
  }
}

//官方推荐
class OfficialPushs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("官方推荐", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 220,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 5),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: OffcialPush(Beans.officialList[0])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: OffcialPush(Beans.officialList[1])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: OffcialPush(Beans.officialList[2])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: OffcialPush(Beans.officialList[3])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: OffcialPush(Beans.officialList[4]))
            ],
          ),
        )
      ],
    );
  }
}

class OffcialPush extends StatelessWidget {
  OffcialPush(@required this.officialBean, {Key key}) : super(key: key);
  OfficialBean officialBean;

  @override
  Widget build(BuildContext context) {
    if(officialBean==null){
      print("为空");
      return null;
    }
    print(officialBean.subTitle+"  "+officialBean.tagColor.toString());
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: FadeInImage.assetNetwork(
          placeholder: "images/default.png",
          image: officialBean.coverPath,
          width: 150,
          height: 150,
        )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Text(officialBean.title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800))),
        Padding(
            padding: EdgeInsets.only(left: 5),
            child: Row(
              children: <Widget>[
                Container(
                  child: Center(child: Text(officialBean.tagName,
                      style: TextStyle(fontSize: 9)),),
                  decoration: BoxDecoration(color: officialBean.tagColor),
                  padding: EdgeInsets.symmetric(horizontal: 2),
                ),
                Text(officialBean.subTitle, style: TextStyle(fontSize: 10 ))
              ],
            ))
      ],
    );
  }
}

//推送条
class PushLine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PushLineState();
  }
}

class PushLineState extends State<PushLine> {
  Timer _timer;
  int index = 0;

  //callback
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(Duration(seconds: 2), callback);
  }

  void callback() {
    setState(() {
      _timer = Timer(Duration(seconds: 2), callback);
      index++;
      if(index>=Beans.pushLineList.length)
        index=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(160, 240, 240, 240),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: "images/icon1.png",
            image: Beans.pushLineList[index].image,
            width: 35,
            height: 35,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(Beans.pushLineList[index].subTitle,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(
            Beans.pushLineList[index].title,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}

// 推送条实体类结构
class PushLineInfo {
  PushLineInfo(this.title, this.content, this.icon);

  String icon;
  String title;
  String content;
}

//底部导航栏
class BottomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(children: <Widget>[
            Icon(Icons.star, color: Colors.greenAccent),
            Text("首页",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.greenAccent))
          ]),
          Column(children: <Widget>[
            Icon(Icons.remove_red_eye, color: Colors.grey),
            Text("动态", style: TextStyle(color: Colors.grey))
          ]),
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.greenAccent, shape: BoxShape.circle),
              child: Icon(Icons.camera_alt)),
          Column(children: <Widget>[
            Icon(Icons.music_video, color: Colors.grey),
            Text("好歌声", style: TextStyle(color: Colors.grey))
          ]),
          Column(children: <Widget>[
            Icon(Icons.person, color: Colors.grey),
            Text("我的", style: TextStyle(color: Colors.grey))
          ]),
        ],
      ),
    );
  }
}

//存储类对象
class Beans {
  static List<PersonBean> personBeanList;
  static List<PushLineBean> pushLineList;
  static List<ButtonBean> buttonList;
  static List<OfficialBean> officialList;
  static int personindex=0;
  static void initPushLine() async {
    if (pushLineList != null) return;
    Map map = await KuGouRequest.getJsonData(KuGouRequest.PUSH_URL);
    pushLineList = PushLineBean.getListFromJSON(map);
  }

  static void initPerson() async {
    if (personBeanList != null) return;
    Map map = await KuGouRequest.getJsonData(KuGouRequest.PERSON_URL);
    personBeanList = PersonBean.getListFromJSON(map);
  }

  static void initButton() async {
    if (buttonList != null) return;
    Map map = await KuGouRequest.getJsonData(KuGouRequest.BUTTON_URL);
    buttonList = ButtonBean.getListFromJSON(map);
  }

  static void initOfficial() async {
    if (officialList != null) return;
    Map map = await KuGouRequest.getJsonData(KuGouRequest.OFFICIAL_URL);
    officialList = OfficialBean.getListFromJSON(map);
  }
}
/*
[data][i][]
bgImg
moduleName
subTitle
 */
