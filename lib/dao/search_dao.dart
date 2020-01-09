import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_trip/model/home_model.dart';


const SEARCH_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

/// 搜索接口
class SearchDao{
  static Future<SearchModel> fetch(String keyword) async{
    final response = await http.get(SEARCH_URL + keyword);
    if(response.statusCode == 200){
      // 只有当输入的内容与服务端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson();
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}