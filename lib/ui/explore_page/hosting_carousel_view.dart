import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HostingCarouselController extends StatelessWidget {
  final CarouselController _controller = CarouselController();
  final List listOfItem;
  final bool? hadDescription;
  final Function(int) onPageChanged;

  HostingCarouselController({
    Key? key,
    required this.listOfItem,
    required this.onPageChanged,
    this.hadDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 35.0),
      height: MediaQuery.of(context).size.height / 2.55 +
          ((hadDescription != null && hadDescription == true) ? 35 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CarouselSlider(
              items: listOfItem
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Column(
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
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollPhysics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                aspectRatio: 0.5,
                autoPlay: false,
                onPageChanged: (value, reason) {
                  onPageChanged(value);
                },
              ),
              carouselController: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
