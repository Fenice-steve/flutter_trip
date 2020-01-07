import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

// 滚动最大距离
const APPBAR_SCROLL_OFFSET = 100;

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _UrlPage = [
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3539459377,966183099&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3539459377,966183099&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3539459377,966183099&fm=26&gp=0.jpg",
  ];

  double appBarAlpha = 0;
  String resultString = "";

  List<CommonModel> localNavList; // local导航
  GridNavModel gridNav; // 网格卡片
  List<CommonModel> subNavList; // 活动导航

  @override
  void initState() {
    super.initState();
    loadData();
  }

  _onScroll(offset) {
    // 滚动距离除以最大滚动距离
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    // 处理滚动时的异常逻辑
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      // appBar的透明度
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  loadData() async{
//      HomeDao.fetch().then((result){
//        setState(() {
//          resultString = json.encode(result);
//        });
//      }).catchError((e){
//        setState(() {
//          resultString = json.encode(e);
//        });
//      });
  try{
    HomeModel model = await HomeDao.fetch();
    setState(() {
      localNavList = model.localNavList;
      gridNav = model.gridNav;
      subNavList = model.subNavList;
    });
  }catch (e){
    print(e);
  }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                // 判断是否是监听更新的对象
                if (scrollNotification is ScrollUpdateNotification &&
                    // 从最外层Widget开始向下遍历查找
                    scrollNotification.depth == 0) {
                  // 滚动且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _UrlPage.length,
                      autoplay: true,
                      // Swiper指示器
                      pagination: SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _UrlPage[index],
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  /// local导航
                  Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 4),child: LocalNav(localNavList: localNavList,),),
                  /// 网格卡片
                  Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),child: GridNav(gridNav:gridNav ),),
                  /// 活动导航
                  Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),child: SubNav(subNavList: subNavList,),),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text(resultString ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // 透明Widget，opacity是必要参数
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
