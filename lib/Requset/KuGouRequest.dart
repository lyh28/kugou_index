import 'dart:convert';
import 'dart:io';
class KuGouRequest{
  static final String BUTTON_URL="http://gzacshow.kugou.com/mfanxing-home/cdn/room/index/module/list?std_plat=1&channel=232&sign=956fc65a47bdb3e3&version=46504&platform=5";    //三个按钮url
  static final String OFFICIAL_URL="http://mo.fanxing.kugou.com/mfx/cdn/official_choice?std_plat=1&channel=232&sign=956fc65a47bdb3e3&version=46504&platform=5";                 //官方推荐url
  static final String PUSH_URL="http://mo.fanxing.kugou.com/mfx/cdn/room/banner_index/v2?bannerType=2&std_plat=1&channel=232&sign=a39a6c959c046948&version=46504&platform=5";   //推送条url
  static final String PERSON_URL="http://gzacshow.kugou.com/mfanxing-home/cdn/room/index/list?gaodeCode=&uiMode=0&std_plat=1&channel=232&sign=11ae6cff303d6e1c&pageSize=16&version=46504&platform=5"
      "&areaName=&page=1&android_id=9a0d4a29e82eb50b6ed13ca7fa4dddae&device=869392020243441%2402%3A00%3A00%3A00%3A00%3A00";         //个人url
  //解析得到响应正文，随后可用json.decode()解析
  static Future<Map> getJsonData(String url) async{
    try{
      HttpClient httpClient=new HttpClient();
      HttpClientRequest request=await httpClient.getUrl((Uri.parse(url)));
      HttpClientResponse response=await request.close();
      var responseBody =await response.transform(utf8.decoder).join();
      Map data=json.decode(responseBody);
      print("请求成功");
      print("响应正文："+responseBody);
      return data;
    }catch(e){
      print("请求失败");
      return null;
    }
  }
}