import 'package:flutter/material.dart';

import 'grid_menu_square.dart';

class GridMenu extends StatelessWidget {
  const GridMenu({
    super.key,
    required this.squares,
    this.axis = Axis.vertical,
    this.crossAxisCount = 2,
    this.padding = 16,
  });

  final List<SquareMenuGrid> squares;
  final Axis axis;
  final int crossAxisCount;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: GridView(
          scrollDirection: axis,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, crossAxisSpacing: 0),
          children: squares,
        ),
      ),
    );
  }
}
