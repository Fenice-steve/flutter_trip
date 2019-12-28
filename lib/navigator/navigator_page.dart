import 'package:flutter/material.dart';
import 'package:flutter_trip/page/home_page.dart';
import 'package:flutter_trip/page/my_page.dart';
import 'package:flutter_trip/page/search_page.dart';
import 'package:flutter_trip/page/travel_page.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 0;

  final Color _iconColor = Colors.grey;
  final Color _activeColor = Colors.blue;

  // 初始化页面控制器
  final PageController _pageController = new PageController(
      // 打开时初始化页面(第一页)
      initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // 禁止pageView左右滑动
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[HomePage(), SearchPage(), MyPage(), TravelPage()],
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
          // 按钮样式
          type: BottomNavigationBarType.fixed,
          // 当前索引值
          currentIndex: _currentIndex,
          // 点击加载某一页面
          onTap: (index) {
            _pageController.jumpToPage(index);
            // 改变索引状态显示
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _iconColor,
              ),
              title: Text(
                "首页",
                style: TextStyle(
                    color: _currentIndex != 0 ? _iconColor : _activeColor),
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _iconColor,
              ),
              title: Text(
                "搜索",
                style: TextStyle(
                    color: _currentIndex != 1 ? _iconColor : _activeColor),
              ),
              activeIcon: Icon(
                Icons.search,
                color: _activeColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                color: _iconColor,
              ),
              title: Text(
                "旅拍",
                style: TextStyle(
                    color: _currentIndex != 2 ? _iconColor : _activeColor),
              ),
              activeIcon: Icon(
                Icons.camera,
                color: _activeColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: _iconColor,
              ),
              title: Text(
                "我的",
                style: TextStyle(
                    color: _currentIndex != 3 ? _iconColor : _activeColor),
              ),
              activeIcon: Icon(
                Icons.person_outline,
                color: _activeColor,
              ),
            ),
          ]),
    );
  }
}
