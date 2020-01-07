import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

/// 网格卡片布局
class GridNav extends StatelessWidget {
  // Widget和它的所有子Widget都是不可变的，所以要用final
  final GridNavModel gridNav;

  const GridNav({@required this.gridNav});

  @override
  Widget build(BuildContext context) {
    // 防止Stack布局不能产生圆角
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      // 裁剪模式
      clipBehavior: Clip.antiAlias,
      // 阴影度
      elevation: 0,
      // 阴影颜色
      shadowColor: Colors.grey,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  /*
  ClipRRect和PhysicalModel的区别在于不能设置z轴、阴影、其他效果和PhysicalModel基本一致
  ClipRRect({
    圆角半径
    this.borderRadius,
    裁剪模式
    this.clipBehavior = Clip.antiAlias,
    Widget child,
  })


  Container 可以做圆角效果。但是不能设置背景颜色。Container一般适用于带边框的无背景颜色的圆角。Container也适用渐变色
  */

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNav == null) return items;
    if (gridNav.hotel != null) {
      items.add(_gridNavItem(context, gridNav.hotel, true));
    }
    if(gridNav.flight != null){
      items.add(_gridNavItem(context, gridNav.flight, false));
    }
    if(gridNav.travel != null){
      items.add(_gridNavItem(context, gridNav.travel, false));
    }
    return items;
  }

  Widget _gridNavItem(
      BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    List<Widget> expandItems = [];
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));

    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    items.forEach((item){
      expandItems.add(Expanded(child: item, flex: 1,));
    });

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(
        top: 1),
      decoration: BoxDecoration(
        // 渐变
        gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(
        children: expandItems,
      ),

    );
  }


  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        model);
  }

  Widget _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[Expanded(child: _item(context, topItem, true)),Expanded(child: _item(context, bottomItem, false))],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    // 横向填充的SizedBox
    return FractionallySizedBox(
      // 撑满宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: first ? borderSide : BorderSide.none)),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WebView(url: model.url,
          statusBarColor: model.statusBarColor,
          hideAppBar: model.hideAppBar,
          title: model.title,)));
      },
      child: widget,
    );
  }
}
