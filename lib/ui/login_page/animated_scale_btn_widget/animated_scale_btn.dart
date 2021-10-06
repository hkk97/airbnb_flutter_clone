import 'package:flutter/material.dart';
import 'package:airbandb/ui/login_page/animated_scale_btn_widget/animated_scale_widget.dart';

class AnimatedScaleBtn extends StatefulWidget {
  final String title;
  final Function onTap;
  final bool isSelected;
  const AnimatedScaleBtn({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  _AnimatedScaleBtnState createState() => _AnimatedScaleBtnState();
}

class _AnimatedScaleBtnState extends State<AnimatedScaleBtn>
    with TickerProviderStateMixin {
  late bool _isSelected;
  void animated() {
    widget.onTap();
    _isSelected = !_isSelected;
    if (!_controller!.isAnimating) {
      _isSelected ? _controller!.forward() : _controller!.reverse();
    }
  }

  late AnimationController? _controller;
  late Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
    _controller = AnimationController(
      upperBound: 1.0,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInExpo,
    );

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
      } else if (status == AnimationStatus.reverse) {
      } else if (status == AnimationStatus.completed) {
        setState(() {});
      } else if (status == AnimationStatus.dismissed) {
        setState(() {});
      } else {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleWidget(
      title: 'Log in',
      onTap: animated,
      controller: _animation!,
    );
  }
}
