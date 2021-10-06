import 'package:airbandb/ui/explore_page/model/stay_informed_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StayInformedWidget extends StatelessWidget {
  final CarouselController _controller = CarouselController();

  StayInformedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey.withOpacity(0.25),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, bottom: 25.0),
                child: Text(
                  "Stay informed",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  items: StayInformedModel.items.map((item) {
                    return CustomColumnItemWidget(
                      model: item,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    scrollPhysics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    aspectRatio: 1.0,
                    autoPlay: false,
                  ),
                  carouselController: _controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomColumnItemWidget extends StatelessWidget {
  final StayInformedModel model;
  const CustomColumnItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  Widget _titleWithSubtitleWidget(BaseTextModel textModel,
      {bool hasUnderLine = true}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textModel.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    textModel.subTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (hasUnderLine)
            Padding(
              padding: const EdgeInsets.only(right: 55),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.section,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 55),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        _titleWithSubtitleWidget(model.fist),
        _titleWithSubtitleWidget(model.second),
        _titleWithSubtitleWidget(model.third, hasUnderLine: false),
      ],
    );
  }
}
