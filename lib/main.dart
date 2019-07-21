import 'package:flutter/material.dart';
import 'TagPagePush.dart';
import 'Requset/KuGouRequest.dart';
import 'dart:async';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }
  void update() {
    Beans.initPerson();
    Beans.initPushLine();
    Beans.initButton();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
