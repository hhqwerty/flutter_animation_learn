import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/*
    ^ y
    |
    |
    -------->x
   /
  /z
 v
*/

class SpinningCardWidget extends StatefulWidget {
  final String urlFront, urlBack;

  SpinningCardWidget({@required this.urlFront, @required this.urlBack, Key key})
      : super(key: key);

  @override
  _SpinningCardWidgetState createState() => _SpinningCardWidgetState();
}

class _SpinningCardWidgetState extends State<SpinningCardWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool isFront = true;
  double verticalDrag = 0;

  setImageSide() {
    isFront = verticalDrag < 90 || verticalDrag > 270;
  }

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails dragStartDetails) {
        controller.reset();
        setState(() {
          verticalDrag = 0.00;
          setImageSide();
        });
      },
      onVerticalDragEnd: (DragEndDetails dragEndDetails) {
        double end = 360 - verticalDrag > 180 ? 0 : 360; // verticalDrag from 0 - 180 => front -> spin back to front, else spin forward to front
        animation =
            Tween<double>(begin: verticalDrag, end:end).animate(controller)
              ..addListener(() {
                setState(() {
                  verticalDrag = animation.value;
                  setImageSide();
                });
              });
        controller.forward();
      },
      onVerticalDragUpdate: (DragUpdateDetails updateDetails) {
        setState(() {
          verticalDrag += updateDetails.delta.dy;
          verticalDrag %= 360;
          setImageSide();
        });
      },
      child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) //3D look
            ..rotateX(verticalDrag / 180 * math.pi),
          child: Image.asset(isFront ? widget.urlFront : widget.urlBack)),
    );
  }
}
