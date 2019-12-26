import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter_trip/model/home_model.dart';


const HOME_URL = 'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/home_page.json';

class HomeDao{
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}