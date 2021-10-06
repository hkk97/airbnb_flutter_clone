import 'package:airbandb/ui/explore_page/host_overlay_widget/any_host_example_widget.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/bottom_btn.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/explore_hosting_widget.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/host_benefit_widget.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/host_overlay_manager.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/hosting_info_widget.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/overlay_close_btn.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/try_host_display_widget.dart';
import 'package:airbandb/ui/explore_page/model/demonstration_model.dart';
import 'package:airbandb/ui/login_page/login_overlay_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

Future<void> showHostingOverlay({
  required BuildContext context,
  required Function onTap,
  OverlayEntry? entry,
  required AnimationController? controller,
  required AnimationController? nestedController,
  required Animation? nestedAnimation,
}) async {
  OverlayEntry? _overlayEntry;
  bool isShrink = false;
  bool _showOverlay = false;
  HostOverlayManager hm = HostOverlayManager();

  OverlayState? _overlayState = Overlay.of(context, rootOverlay: true);
  entry = OverlayEntry(
    builder: (BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Material(
          color: Colors.transparent,
          child: _AnimatedScaleWidget(
            backgroundColorNotifier: hm.backgroundNotifier(),
            controller: nestedController,
            isShrink: isShrink,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () async {
                      await controller!.reverse().whenComplete(() {
                        controller = null;
                        entry!.remove();
                        entry = null;
                        onTap();
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: controller!,
                  builder: (BuildContext context, Widget? child) {
                    if (controller == null) {
                      return const SizedBox();
                    }
                    return ValueListenableBuilder<double?>(
                        valueListenable: hm.verticalOffsetNotifier(),
                        builder: (BuildContext context, value, Widget? child) {
                          return Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            top: MediaQuery.of(context).size.height *
                                ((1 - controller!.value) < 0.05
                                    ? 0
                                    : (1 - controller!.value)),
                            child: GestureDetector(
                              onDoubleTap: () {},
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return Container(
                                    color: Colors.black,
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            controller: hm.scrollController(),
                                            physics:
                                                const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics(),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  height: 500,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                        child: FutureBuilder(
                                                          future: hm
                                                              .initializeVideoPlayerFuture1(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              return AspectRatio(
                                                                aspectRatio: hm
                                                                    .videoController1()
                                                                    .value
                                                                    .aspectRatio,
                                                                child:
                                                                    VideoPlayer(
                                                                  hm.videoController1(),
                                                                ),
                                                              );
                                                            } else {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      ValueListenableBuilder<
                                                          bool>(
                                                        valueListenable:
                                                            hm.playNotifier1(),
                                                        builder: (context,
                                                            value, child) {
                                                          late IconData
                                                              iconData;
                                                          value == true
                                                              ? iconData = Icons
                                                                  .stop_circle_outlined
                                                              : iconData = Icons
                                                                  .play_circle;
                                                          return Positioned(
                                                            left: 20,
                                                            bottom: 160,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (hm
                                                                    .videoController1()
                                                                    .value
                                                                    .isPlaying) {
                                                                  hm
                                                                      .videoController1()
                                                                      .pause();
                                                                  hm
                                                                      .playNotifier1()
                                                                      .value = false;
                                                                } else {
                                                                  hm
                                                                      .videoController1()
                                                                      .play();
                                                                  hm
                                                                      .playNotifier1()
                                                                      .value = true;
                                                                }
                                                              },
                                                              child: Icon(
                                                                  iconData,
                                                                  size: 26.0,
                                                                  color: value
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      ValueListenableBuilder<
                                                          int>(
                                                        valueListenable: hm
                                                            .subTitleNotifier(),
                                                        builder: (context,
                                                            value, child) {
                                                          return Positioned(
                                                            left: 20,
                                                            bottom: 45,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 45,
                                                                  child: Image(
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                    image:
                                                                        AssetImage(
                                                                      DemonstrationModel
                                                                          .items[
                                                                              value]
                                                                          .assetImage,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: 160,
                                                                  child: Text(
                                                                    DemonstrationModel
                                                                        .items[
                                                                            value]
                                                                        .label,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 0,
                                                        child: SizedBox(
                                                          height: 25,
                                                          width: MediaQuery.of(
                                                            context,
                                                          ).size.width,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                  10.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const HostingInofoWidget(),
                                                AnyHostExampleWidget(
                                                  anyHost: hm.anyHostNotifier(),
                                                ),
                                                ExporeHostingWidget(
                                                  onTap: () async {
                                                    if (_showOverlay == false) {
                                                      _showOverlay = true;
                                                      hm
                                                          .backgroundNotifier()
                                                          .value = true;
                                                      hm.updateOffset();
                                                      hm.onShrink(
                                                        controller!,
                                                        isShrink,
                                                      );

                                                      showLoginOverlay(
                                                        controller:
                                                            nestedController,
                                                        context: context,
                                                        entry: _overlayEntry,
                                                        onTap: () async {
                                                          await hm.onShrink(
                                                            controller!,
                                                            isShrink,
                                                          );

                                                          hm
                                                              .backgroundNotifier()
                                                              .value = false;
                                                          _showOverlay = false;
                                                        },
                                                      ).whenComplete(
                                                        () => nestedController!
                                                            .forward()
                                                            .whenComplete(
                                                              () => hm
                                                                  .scrollController()
                                                                  .jumpTo(
                                                                    hm.verticleOffset(),
                                                                  ),
                                                            ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                const HostBenefitWidget(),
                                                SizedBox(
                                                  key: hm.tryHostKey(),
                                                  height: 500,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                        child: FutureBuilder(
                                                          future: hm
                                                              .initializeVideoPlayerFuture2(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              return AspectRatio(
                                                                aspectRatio: hm
                                                                    .videoController2()
                                                                    .value
                                                                    .aspectRatio,
                                                                child:
                                                                    VideoPlayer(
                                                                  hm.videoController2(),
                                                                ),
                                                              );
                                                            } else {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      ValueListenableBuilder<
                                                          bool>(
                                                        valueListenable:
                                                            hm.playNotifier2(),
                                                        builder: (context,
                                                            value, child) {
                                                          late IconData
                                                              iconData;
                                                          value == true
                                                              ? iconData = Icons
                                                                  .stop_circle_outlined
                                                              : iconData = Icons
                                                                  .play_circle;
                                                          return Positioned(
                                                            left: 20,
                                                            bottom: 50,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (hm
                                                                    .videoController2()
                                                                    .value
                                                                    .isPlaying) {
                                                                  hm
                                                                      .videoController2()
                                                                      .pause();
                                                                  hm
                                                                      .playNotifier2()
                                                                      .value = false;
                                                                } else {
                                                                  hm
                                                                      .videoController2()
                                                                      .play();
                                                                  hm
                                                                      .playNotifier2()
                                                                      .value = true;
                                                                }
                                                              },
                                                              child: Icon(
                                                                  iconData,
                                                                  size: 26.0,
                                                                  color: value
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 0,
                                                        child: SizedBox(
                                                          height: 25,
                                                          width: MediaQuery.of(
                                                            context,
                                                          ).size.width,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 0),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                  10.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const TryHostDisplayWidget(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (constraints.maxHeight > 75)
                                          ValueListenableBuilder<List>(
                                            valueListenable: hm.jointNotifier(),
                                            builder: (context, value, child) {
                                              return BottomBtn(
                                                isJoinded: value[0],
                                                color: value[1],
                                                onTap: () async {
                                                  if (_showOverlay == false) {
                                                    _showOverlay = true;
                                                    hm
                                                        .backgroundNotifier()
                                                        .value = true;
                                                    hm.updateOffset();

                                                    hm.onShrink(
                                                      controller!,
                                                      isShrink,
                                                    );

                                                    showLoginOverlay(
                                                      controller:
                                                          nestedController,
                                                      context: context,
                                                      entry: _overlayEntry,
                                                      onTap: () async {
                                                        await hm.onShrink(
                                                          controller!,
                                                          isShrink,
                                                        );
                                                        hm
                                                            .backgroundNotifier()
                                                            .value = false;
                                                        _showOverlay = false;
                                                      },
                                                    ).whenComplete(
                                                      () => nestedController!
                                                          .forward()
                                                          .whenComplete(
                                                            () => hm
                                                                .scrollController()
                                                                .jumpTo(
                                                                  hm.verticleOffset(),
                                                                ),
                                                          ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        });
                  },
                ),
                AnimatedBuilder(
                  animation: controller!,
                  builder: (BuildContext context, Widget? child) {
                    if (controller == null) {
                      return const SizedBox();
                    }
                    return ValueListenableBuilder(
                      valueListenable: hm.verticalOffsetNotifier(),
                      builder: (BuildContext context, value, Widget? child) {
                        return Positioned(
                          left: 20,
                          top: MediaQuery.of(context).size.height *
                                  ((1 - controller!.value) < 0.05
                                      ? 0
                                      : (1 - controller!.value)) +
                              50,
                          child: OverlayCloseBtn(
                            onTap: () async {
                              await controller!.reverse().whenComplete(() {
                                controller = null;
                                entry!.remove();
                                entry = null;
                                onTap();
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  _overlayState!.insert(entry!);
}

class _AnimatedScaleWidget extends AnimatedWidget {
  final Widget child;
  final bool isShrink;
  final ValueNotifier<bool> backgroundColorNotifier;
  const _AnimatedScaleWidget({
    Key? key,
    controller,
    required this.child,
    required this.isShrink,
    required this.backgroundColorNotifier,
  }) : super(key: key, listenable: controller);

  Animation<double> get controller => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: backgroundColorNotifier.value ? Colors.black : Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          left: controller.value * 12,
          right: controller.value * 12,
          top: controller.value * 45,
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
                color: backgroundColorNotifier.value
                    ? Colors.white
                    : Colors.transparent,
                child: child,
              ),
      ),
    );
  }
}
