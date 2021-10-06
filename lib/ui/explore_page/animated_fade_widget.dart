import 'package:airbandb/ui/explore_page/model/host_anywhere_model.dart';
import 'package:flutter/material.dart';

class AnimatedFadeWidget extends StatefulWidget {
  final HostAnyWhereModel model;
  const AnimatedFadeWidget({Key? key, required this.model}) : super(key: key);

  @override
  _AnimatedFadeWidgetState createState() => _AnimatedFadeWidgetState();
}

class _AnimatedFadeWidgetState extends State<AnimatedFadeWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget> _texts = [];
    final texts = widget.model.description.split('\t');
    for (var element in texts) {
      _texts.add(Text(
        element,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
      ));
      if (texts.indexOf(element) + 1 < texts.length - 1) {
        _texts.add(const SizedBox(
          height: 3.0,
        ));
      }
    }

    return FadeTransition(
      opacity: _animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _texts,
          ),
          const SizedBox(height: 25.0),
          SizedBox(
            height: 30,
            child: Image(
              image: AssetImage(widget.model.signImage),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            widget.model.label,
            style: const TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
