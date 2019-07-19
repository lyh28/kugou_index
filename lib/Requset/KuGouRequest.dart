class KuGouRequest{
  static final String BUTTON_URL="http://gzacshow.kugou.com/mfanxing-home/cdn/room/index/module/list?std_plat=1&channel=232&sign=956fc65a47bdb3e3&version=46504&platform=5";    //三个按钮url
  static final String OFFICIAL_URL="http://mo.fanxing.kugou.com/mfx/cdn/official_choice?std_plat=1&channel=232&sign=956fc65a47bdb3e3&version=46504&platform=5";                 //官方推荐url
  static final String PUSH_URL="http://mo.fanxing.kugou.com/mfx/cdn/room/banner_index/v2?bannerType=2&std_plat=1&channel=232&sign=a39a6c959c046948&version=46504&platform=5";   //推送条url
  static final String PERSON_URL="http:///mfanxing-home/cdn/room/index/list?gaodeCode=&uiMode=0&std_plat=1&channel=232&sign=11ae6cff303d6e1c&pageSize=16&version=46504&platform=5"
      "&areaName=&page=1&android_id=9a0d4a29e82eb50b6ed13ca7fa4dddae&device=869392020243441%2402%3A00%3A00%3A00%3A00%3A00";         //个人url
  //解析得到响应正文，随后可用json.decode()解析
  static Map getJsonData(String url) async{
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
}