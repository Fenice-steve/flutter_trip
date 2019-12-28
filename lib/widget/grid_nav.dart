import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  // Widget和它的所有子Widget都是不可变的，所以要用final
  final GridNavModel gridNavModel;

  const GridNav({@required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
