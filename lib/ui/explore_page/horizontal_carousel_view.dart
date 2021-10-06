import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HorizontalCarouselController extends StatelessWidget {
  final CarouselController _controller = CarouselController();
  final String title;
  final List listOfItem;
  final bool? hadDescription;

  HorizontalCarouselController({
    Key? key,
    required this.title,
    required this.listOfItem,
    this.hadDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 35.0),
      height: MediaQuery.of(context).size.height / 2 +
          ((hadDescription != null && hadDescription == true) ? 35 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 25.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.label,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (hadDescription != null && hadDescription == true)
                            SizedBox(
                              height: 35,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.description,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                  ),
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
                aspectRatio: 1.0,
                autoPlay: false,
              ),
              carouselController: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
