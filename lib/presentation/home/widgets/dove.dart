import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoveAnimated extends StatefulWidget {
  const DoveAnimated({Key? key}) : super(key: key);

  @override
  _DoveAnimatedState createState() => _DoveAnimatedState();
}

class _DoveAnimatedState extends State<DoveAnimated>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      upperBound: 1.0,
      lowerBound: 0.7,
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(20.0),
      width: width / 1.2,
      height: width / 1.2,
      // child: RotationTransition(
      //   turns: CurvedAnimation(
      //     parent: _animationController,
      //     curve: Curves.slowMiddle,
      //   ),
      //   child: SvgPicture.asset('assets/dove.svg'),
      // ),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOutExpo,
        ),
        child: SvgPicture.asset('assets/dove.svg'),
      ),
    );
  }
}
