import 'package:airbandb/util/notification_bar_util.dart';
import 'package:flutter/material.dart';

class AnimatedScaleButtonWidget<T extends StatefulWidget> extends State<T>
    with TickerProviderStateMixin {
  bool isShrink = false;
  double shiftedDy = 20;
  double shiftedDx = 20;
  late AnimationController? controller;
  late Animation<double>? animation;

  Future<void> onShrink() async {
    if (!controller!.isAnimating) {
      isShrink = !isShrink;

      isShrink ? controller!.forward() : controller!.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      upperBound: 1.0,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeInExpo,
    );

    controller!.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
      } else if (status == AnimationStatus.reverse) {
      } else if (status == AnimationStatus.completed) {
        // setState(() {});
      } else if (status == AnimationStatus.dismissed) {
        // setState(() {});
      } else {}
    });
    isShrink ? controller!.forward() : null;
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  Widget animatedScaleWidget(Widget child) {
    return _AnimatedScaleWidget(
      shiftedDx: shiftedDx,
      shiftedDy: shiftedDy,
      controller: animation,
      child: child,
      isShrink: isShrink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _AnimatedScaleWidget extends AnimatedWidget {
  final Widget child;
  final bool isShrink;
  final double shiftedDx;
  final double shiftedDy;

  const _AnimatedScaleWidget({
    Key? key,
    controller,
    required this.child,
    required this.shiftedDx,
    required this.shiftedDy,
    required this.isShrink,
  }) : super(key: key, listenable: controller);

  Animation<double> get controller => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: controller.value * shiftedDx,
        right: controller.value * shiftedDx,
        top: controller.value * shiftedDy,
        bottom: controller.value * shiftedDy,
      ),
      child: isShrink
          ? Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: child,
            )
          : Container(
              color: Colors.transparent,
              child: child,
            ),
    );
  }
}
