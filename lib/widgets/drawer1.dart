import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/*
 - Blue element is behind yellow element      done
 - Yellow element is getting smaller
 - Yellow element is moving to the right
 - Transition is smooth

 */

class Drawer1 extends StatefulWidget {
  @override
  _Drawer1State createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  Widget mDrawer = Container(
    color: Colors.blue,
  );
  Widget mBody = Container(color: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        mDrawer,
        mBody
      ],
    );
  }
}
