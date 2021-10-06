import 'package:airbandb/util/notification_bar_util.dart';
import 'package:flutter/material.dart';

class AnimatedScaleScreenWidget<T extends StatefulWidget> extends State<T>
    with TickerProviderStateMixin {
  bool isShrink = false;
  late AnimationController? controller;
  late Animation<double>? animation;

  void onShrink() async {
    if (!controller!.isAnimating) {
      isShrink = !isShrink;

      isShrink
          ? changeNotificationBarColor(Colors.black,
                  iconBrightness: Brightness.light)
              .whenComplete(() => controller!.forward())
          : controller!.reverse().whenComplete(() => changeNotificationBarColor(
              Colors.white,
              iconBrightness: Brightness.dark));
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
        setState(() {});
      } else if (status == AnimationStatus.dismissed) {
        setState(() {});
      } else {}
    });
    isShrink ? controller!.forward() : null;
  }

  @override
  void dispose() {
    if (!mounted) {
      controller!.dispose();
    }
    super.dispose();
  }

  Widget animatedScaleWidget(Widget child) {
    return _AnimatedScaleWidget(
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
  const _AnimatedScaleWidget({
    Key? key,
    controller,
    required this.child,
    required this.isShrink,
  }) : super(key: key, listenable: controller);

  Animation<double> get controller => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(
          left: controller.value * 12,
          right: controller.value * 12,
          top: controller.value * 15,
        ),
        child: isShrink
            ? Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: child,
              )
            : Container(
                color: Colors.white,
                child: child,
              ),
      ),
    );
  }
}
