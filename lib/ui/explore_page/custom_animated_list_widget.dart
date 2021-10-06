import 'package:after_layout/after_layout.dart';
import 'package:airbandb/ui/explore_page/model/living_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedListWidget extends StatefulWidget {
  final Function(String)? selectedValue;
  final String? referHeight;
  const AnimatedListWidget({
    Key? key,
    this.referHeight,
    this.selectedValue,
  }) : super(key: key);
  @override
  AnimatedListWidgetState createState() => AnimatedListWidgetState();
}

class AnimatedListWidgetState extends State<AnimatedListWidget>
    with AfterLayoutMixin {
  final ScrollController _scrollController = ScrollController();
  late ScrollPhysics? _scrollPhysics;
  bool isScrolling = true;
  bool isAnimated = false;
  double topContainer = 0;
  late double itemHeight = 0;

  @override
  Widget build(BuildContext context) {
    itemHeight = MediaQuery.of(context).size.height / 2;
    _scrollPhysics = CustomScrollPhysics(
        parent: const BouncingScrollPhysics(),
        itemDimension: itemHeight,
        selectedIndex: (index) {
          // widget.selectedValue);
        });

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListWheelScrollView(
        controller: _scrollController,
        itemExtent: itemHeight,
        children: childWidgets(),
        magnification: 1.3,
        useMagnifier: true,
        diameterRatio: 1.75,
        physics: _scrollPhysics,
      ),
    );
  }

  List<Widget> childWidgets() {
    return LivingModel.items
        .map(
          (item) => Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(item.assetImage),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        )
        .toList();
  }

  Future<void> animatedScroll(double offset) async {
    _scrollController.jumpTo(offset);
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    // if (widget.referHeight != null) {
    //   if (ProfileModel.heightModel.options!.contains(widget.referHeight)) {
    //     await animatedScroll(
    //         ProfileModel.heightModel.options!.indexOf(widget.referHeight!) *
    //             itemHeight);
    //   }
    // } else {
    //   await animatedScroll(
    //       (ProfileModel.heightModel.options!.length / 3).round() * itemHeight);
    // }
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double? itemDimension;
  final Function(int)? selectedIndex;

  const CustomScrollPhysics(
      {this.itemDimension, this.selectedIndex, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension,
        selectedIndex: selectedIndex,
        parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / itemDimension!;
  }

  double _getPixels(double page) {
    return page * itemDimension!;
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    selectedIndex!(page.round());
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
