import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_animation/widgets/spinning_card.dart';

/*
 - Blue element is behind yellow element      done
 - Yellow element is getting smaller      done
 - Yellow element is moving to the right   done
 - Transition is smooth
 */

const double DEFAULT_SCALE = 0.3;
const double DEFAULT_TRANSLATE= 225;

class Drawer1 extends StatefulWidget {
  @override
  _Drawer1State createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> with SingleTickerProviderStateMixin<Drawer1> {
  double translateValue;
  AnimationController _controller;
  Widget mDrawer = Container(
    color: Colors.blue,
    alignment: Alignment.center,
    child: Text('Drawer'),
  );
  Widget mBody = Container(color: Colors.yellow,alignment: Alignment.center, child: SpinningCardWidget( urlBack: 'assets/1_back.png',urlFront: 'assets/1_front.png',),);

  @override
  void initState() {
    _controller = new AnimationController(vsync: this, duration:Duration(milliseconds: 200));
    super.initState();
  }

  void toggle(){
    if(_controller.isDismissed){
      _controller.forward();
    }else{
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          mDrawer,
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = 1-(_controller.value*DEFAULT_SCALE);
              double slide =  _controller.value*DEFAULT_TRANSLATE;
              return Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..scale(scale)
                    ..translate(slide),
                  child: mBody,
              );
            },
          )
        ],
      ),
    );
  }
}
