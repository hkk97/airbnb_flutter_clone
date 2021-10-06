import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:airbandb/ui/login_page/model/auth_item.dart';

Future<void> showLoginOverlay({
  required BuildContext context,
  required Function onTap,
  OverlayEntry? entry,
  required AnimationController? controller,
}) async {
  ValueNotifier<double> verticalOffsetNotifier = ValueNotifier(0);
  OverlayState? _overlayState = Overlay.of(context, rootOverlay: true);
  entry = OverlayEntry(
    builder: (BuildContext context) => SafeArea(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () async {
                    await controller!.reverse().whenComplete(() {
                      entry!.remove();
                      entry = null;
                      controller = null;
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
                  return ValueListenableBuilder(
                      valueListenable: verticalOffsetNotifier,
                      builder: (BuildContext context, value, Widget? child) {
                        return Positioned(
                          left: 0,
                          right: 0,
                          bottom: verticalOffsetNotifier.value < 0
                              ? -verticalOffsetNotifier.value
                              : 0,
                          top: MediaQuery.of(context).size.height *
                                  ((1 - controller!.value) < 0.05
                                      ? 0.05
                                      : (1 - controller!.value)) +
                              verticalOffsetNotifier
                                  .value, // 0.25 + offset when drag down, - offset when draw up +-30
                          child: GestureDetector(
                            dragStartBehavior: DragStartBehavior.down,
                            onVerticalDragUpdate: (detail) async {
                              if (detail.localPosition.dy > 150) {
                                verticalOffsetNotifier.value = 0.0;
                                await controller!
                                    .reverse(
                                        from: (MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                150) /
                                            MediaQuery.of(context).size.height)
                                    .whenComplete(() {
                                  entry!.remove();
                                  entry = null;
                                  controller = null;
                                  onTap();
                                });
                              } else {
                                verticalOffsetNotifier.value =
                                    detail.localPosition.dy;
                              }
                            },
                            onVerticalDragEnd: (detail) {
                              verticalOffsetNotifier.value = 0.0;
                            },
                            onDoubleTap: () {},
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, spreadRadius: 1.0)
                                  ]),
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return SizedBox(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth,
                                    child: Column(
                                      children: [
                                        constraints.maxHeight > 25
                                            ? SizedBox(
                                                height: 25,
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10.0,
                                                  ),
                                                  width: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                5.0),
                                                          ),
                                                          color: Colors.grey),
                                                ),
                                              )
                                            : const SizedBox(),
                                        constraints.maxHeight > 75
                                            ? SizedBox(
                                                height: 50,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () async {
                                                            await controller!
                                                                .reverse()
                                                                .whenComplete(
                                                                    () {
                                                              entry!.remove();
                                                              entry = null;
                                                              controller = null;
                                                              onTap();
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.close)),
                                                      const Text(
                                                        "Log in or sign up",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      IgnorePointer(
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.nature,
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        constraints.maxHeight > 80
                                            ? Container(
                                                height: 1,
                                                color: Colors.grey,
                                              )
                                            : const SizedBox(),
                                        Expanded(
                                            child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics(),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 25, horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  height: 60,
                                                  child: Card(
                                                    margin:
                                                        const EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(0.45),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 12.0,
                                                            horizontal: 15.0,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Country/Region",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 3.0,
                                                              ),
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Hong Kong (+852)",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 5,
                                                              //   child: FittedBox(
                                                              //     fit: BoxFit.fitHeight,
                                                              //     child: Text(
                                                              //       "Hong Kong (+852)",
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon:
                                                              Transform.rotate(
                                                            angle:
                                                                90 * pi / 180,
                                                            child: Icon(Icons
                                                                .arrow_forward_ios_sharp),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                  child: Card(
                                                    margin:
                                                        const EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(0.45),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 15.0,
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Phone number",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text(
                                                  "We'll call or text you to confirm your number. Standard message and data rates apply.",
                                                  maxLines: 3,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const SizedBox(
                                                  height: 60,
                                                  child: Card(
                                                    color: Colors.red,
                                                    child: Center(
                                                      child: Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 35.0),
                                                  child: SizedBox(
                                                    height: 25.0,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15.0),
                                                          child: Text(
                                                            'or',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            height: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: AuthItem.items.map(
                                                    (item) {
                                                      Widget authIcon = Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 15.0,
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                            item.assetImage,
                                                          ),
                                                        ),
                                                      );
                                                      Widget emptyIcon =
                                                          Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 15.0,
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                            item.assetImage,
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                      );
                                                      return Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 55,
                                                            child: Card(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                side:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.45),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15.0),
                                                                child: Row(
                                                                  children: [
                                                                    authIcon,
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        item.label,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    emptyIcon,
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          if (AuthItem.items
                                                                  .indexOf(
                                                                      item) !=
                                                              AuthItem.items
                                                                      .length -
                                                                  1)
                                                            const SizedBox(
                                                                height: 15.0)
                                                        ],
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
  _overlayState!.insert(entry!);
}
