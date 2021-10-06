import 'package:airbandb/ui/common/animated_scale_screen_widget.dart';
import 'package:airbandb/ui/explore_page/horizontal_carousel_view.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/host_overlay_manager.dart';
import 'package:airbandb/ui/explore_page/model/discover_model.dart';
import 'package:airbandb/ui/explore_page/model/living_model.dart';
import 'package:airbandb/ui/explore_page/stay_informed_widget.dart';
import 'package:airbandb/ui/explore_page/try_host_widget.dart';
import 'package:airbandb/util/notification_bar_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExplorePage extends StatefulWidget {
  final bool isShrink;
  const ExplorePage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends AnimatedScaleScreenWidget<ExplorePage> {
  late ScrollController _scrollController;
  late ValueNotifier<double> _offSetNotifier;
  late ValueNotifier<double> _scrollNotifier;
  final Shader textGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    changeNotificationBarColor(Colors.black, iconBrightness: Brightness.light);
    isShrink = widget.isShrink;
    _scrollController = ScrollController(initialScrollOffset: 0);
    _offSetNotifier = ValueNotifier(0);
    _scrollNotifier = ValueNotifier(0);
    _scrollController.addListener(() {
      if (_scrollController.offset < 0) {
        _scrollController.jumpTo(0);
      }
      _scrollNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (!mounted) {
      _scrollController.dispose();
      HostOverlayManager().dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Column(
      children: [
        HorizontalCarouselController(
          title: "Live anywhere",
          listOfItem: LivingModel.items,
        ),
        const TryHostWidget(),
        HorizontalCarouselController(
          title: "Discover things to do",
          listOfItem: DiscoverModel.items,
          hadDescription: true,
        ),
        StayInformedWidget(),
      ],
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ValueListenableBuilder<double>(
                      valueListenable: _offSetNotifier,
                      builder:
                          (BuildContext context, verticalDragValue, child) {
                        return Column(
                          children: [
                            ValueListenableBuilder<double>(
                              valueListenable: _scrollNotifier,
                              builder: (context, scrollValue, child) {
                                double opacity = 1.0;
                                double height = 500 + verticalDragValue * 2.5;
                                if (scrollValue == 0) {
                                  opacity = 1.0;
                                } else if (scrollValue > 0 &&
                                    scrollValue < height) {
                                  opacity = 1 - (scrollValue / height);
                                } else if (scrollValue > height) {
                                  opacity = 0;
                                }
                                return Opacity(
                                  opacity: opacity,
                                  child: SizedBox(
                                    height: 500 + verticalDragValue * 2.5,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: -1 * verticalDragValue,
                                          right: -1 * verticalDragValue,
                                          bottom: 0,
                                          child: GestureDetector(
                                            onVerticalDragUpdate:
                                                (detail) async {
                                              if (detail.localPosition.dy >
                                                  150) {
                                                _offSetNotifier.value =
                                                    detail.localPosition.dy /
                                                        15;
                                              } else {}
                                            },
                                            onVerticalDragEnd: (detail) {
                                              _offSetNotifier.value = 0.0;
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: AssetImage(
                                                    'assets/header_bg.webp',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ValueListenableBuilder<double>(
                                          valueListenable: _scrollNotifier,
                                          builder: (BuildContext context, value,
                                              Widget? child) {
                                            return Positioned(
                                              top: 250 + value,
                                              left: 25,
                                              right: 25,
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Not sure where to go?",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    const Text(
                                                      "Perfect.",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15.0,
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                      width: 150,
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          side: BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.45),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0,
                                                                  horizontal:
                                                                      15.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              child: Text(
                                                                "I'm flexible",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  foreground: Paint()
                                                                    ..shader =
                                                                        textGradient,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 2.42,
                              child: Stack(
                                children: [
                                  ValueListenableBuilder<double>(
                                    valueListenable: _scrollNotifier,
                                    builder: (context, value, child) {
                                      late double top_dy;
                                      value > 350
                                          ? top_dy = value > 350 + 45 ? -180 : 0
                                          : top_dy = 0;
                                      return Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: childWidget,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: _scrollNotifier,
                      builder: (context, value, child) {
                        bool asAppBar = false;
                        bool isShifted = false;
                        late double diff;
                        late double top_dy;

                        if (value > 350) {
                          if (value > 350 + 50) {
                            top_dy = value - 50;
                            asAppBar = true;
                            changeNotificationBarColor(
                              Colors.white,
                              iconBrightness: Brightness.dark,
                            );
                          } else {
                            top_dy = 350;
                            diff = value - 350;
                            isShifted = true;
                            changeNotificationBarColor(
                              Colors.black,
                              iconBrightness: Brightness.light,
                            );
                          }
                        } else {
                          top_dy = value;
                        }
                        return Positioned(
                          top: 45 + top_dy,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: asAppBar
                                ? Colors.white
                                : isShifted
                                    ? Colors.grey.withOpacity((1 - (diff / 50)))
                                    : Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10.0),
                            child: SizedBox(
                              height: 50,
                              child: Card(
                                color: asAppBar
                                    ? const Color.fromRGBO(237, 239, 242, 1.0)
                                    : isShifted
                                        ? Color.fromRGBO(237, 239, 242,
                                            (1 - (diff / 50) - 0.5).abs())
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(237, 239, 242, 0.5),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.5, horizontal: 5.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: Image(
                                          image: AssetImage(
                                            'assets/icon/search_btn.png',
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Where are you going?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: _scrollNotifier,
                      builder: (context, value, child) {
                        late double top_dy;
                        value > 330
                            ? top_dy = value - (value - 330)
                            : top_dy = value;
                        return Positioned(
                          top: 0 + top_dy,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 25,
                            color: Colors.black,
                            child: const Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Get the letest on our COVID-19 response",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
