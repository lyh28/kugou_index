import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'Requset/KuGouRequest.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue),
        home: MainPage());
  }
}

//主页
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {

//String url="https://www.baidu.com";
  void askQuest() async{
    try{
      HttpClient httpClient=new HttpClient();
      HttpClientRequest request=await httpClient.getUrl((Uri.parse(KuGouRequest.BUTTON_URL)));
//      request.headers.add("user-agent", "Android800-Phone-201-0-FANet-cmnet(13)");
//      request.headers.add("Accept-", value)
      HttpClientResponse response=await request.close();
      var text=await response.transform(utf8.decoder).join();
      Map data=json.decode(text);
      var str1=data["data"];
      String modulename=str1[1]["moduleName"];
      String bgImg=str1[1]["bgImg"];
      String subTitle=str1[1]["subTitle"];
      print("text: \n"+text);
      print("module: "+modulename);
      print("bgImg: "+bgImg);
      print("subTitle:  "+subTitle);
    }catch(e){
      print("请求失败");
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: askQuest),
        body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      TitlePage(),
      Expanded(
        child: ChooseType(),
      ),
      BottomView()
    ]));
  }
}

//标题栏
class TitlePage extends StatelessWidget {
  TitlePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: ConstrainedBox(
      constraints: BoxConstraints(minHeight: 32.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.grade),
            ),
            Expanded(flex: 2, child: SearchView()),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(Icons.access_time),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.favorite_border),
            )
          ]),
    ));
  }
}

//搜索栏
class SearchView extends StatelessWidget {
  SearchView({hint = "搜索"}) {
    this.hint = hint;
  }

  String hint;
  String content;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        //Color.fromARGB(250,248, 248, 248)
        height: 32,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(250, 230, 230, 230)),
          child: Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("输入房间号、昵称和歌曲名",
                        style: TextStyle(color: Colors.grey)),
                  )
                ],
              )),
        ));
  }
}

//选择 Layout
class ChooseType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChooseTypeState();
}

//选择栏
class _ChooseTypeState extends State<ChooseType>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tablist = ["关注", "推荐", "附近", "歌手", "颜值", "新秀", "特色"];
  var tabs = <Widget>[
    Tab(text: "关注"),
    TabPagePush(),
    Tab(text: "附近"),
    Tab(text: "歌手"),
    Tab(text: "颜值"),
    Tab(text: "新秀"),
    Tab(text: "特色"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tablist.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
      TabBar(
          indicatorPadding: EdgeInsets.only(bottom: 7),
          controller: _tabController,
          isScrollable: false,
          labelStyle: TextStyle(fontSize: 12.0),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.greenAccent,
          labelColor: Colors.black,
          tabs: tablist
              .map((e) => Tab(
                    text: e,
                  ))
              .toList()),
      Container(height: 0.1, color: Colors.grey, child: Row()),
      Expanded(
          child: TabBarView(
        controller: _tabController,
        children: tabs,
      ))
    ]);
  }
}

//推荐页
class TabPagePush extends StatelessWidget {
  TabPagePush({Key key}) : super(key: key);

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
              Expanded(child: createIcon("images/icon1.png", "抢红包", "一起拼手气")),
              Expanded(child: createIcon("images/icon2.png", "首唱会", "火热预约中")),
              Expanded(child: createIcon("images/icon3.png", "点歌广场", "悬赏点歌"))
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
//          Column(children: <Widget>[PushIndexs()])
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
          child: Image(
            width: 35,
            height: 35,
            image: AssetImage(icon),
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
    return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        childAspectRatio: 0.88,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        children: <Widget>[
          PushIndex(),
          PushIndex(),
          PushIndex(),
          PushIndex(),
        ]);
  }
}

class PushIndex extends StatelessWidget {
  PushIndex(
      {Key key,
      this.name: "名字",
      this.title: "标题",
      this.pic,
      this.ps: "左上角",
      this.isexpand: true})
      : super(key: key);
  String name;
  String title;
  String pic;
  String ps; //左上角
  //是否扩展图片
  bool isexpand;

  StackFit getStackFit() {
    if (isexpand) {
      print("扩展");
      return StackFit.expand;
    } else
      print("不扩展");

    return StackFit.loose;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
              child: Stack(
            fit: getStackFit(),
            alignment: Alignment.centerRight,
            children: <Widget>[
              Text(ps),
              Image(
                image: AssetImage("images/person1.png"),
                fit: BoxFit.fitWidth,
              )
            ],
          )),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Text(title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800))),
        Container(
            padding: EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
            child: Text(name, style: TextStyle(fontSize: 10))),
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
                  child: PushIndex(isexpand: false)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: PushIndex(isexpand: false)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: PushIndex(isexpand: false)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: PushIndex(isexpand: false)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: PushIndex(isexpand: false),
              ),
            ],
          ),
        )
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
  int index;
  List<PushLineInfo> pushLineInfo = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    //_timer = new Timer(new Duration(seconds: 2), callback);
    pushLineInfo.add(PushLineInfo("酷狗首唱会", "才华满分！"));
  }

  //callback
  void callback() {}

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
          Icon(Icons.music_video),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(pushLineInfo[0].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(pushLineInfo[0].content)
        ],
      ),
    );
  }
}

// 推送条实体类结构
class PushLineInfo {
  PushLineInfo(this.title, this.content, {this.icon});

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
