import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  // Widget和它的所有子Widget都是不可变的，所以要用final
  final GridNavModel gridNav;

  const GridNav({@required this.gridNav});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(color: Colors.transparent,
    borderRadius: BorderRadius.circular(6),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: <Widget>[

      ],
    ),);
  }

  List<Widget> _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gridNav==null)return items;
    if(gridNav.hotel != null){
    }
  }

  Widget _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first){
    List<Widget> items =[];
    List<Widget> expandItems = [];

  }
}
