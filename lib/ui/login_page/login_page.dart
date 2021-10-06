import 'package:flutter/material.dart';
import 'package:airbandb/ui/common/animated_scale_screen_widget.dart';
import 'package:airbandb/ui/login_page/login_overlay_widget.dart';
import 'package:airbandb/ui/login_page/model/extra_info_item.dart';

class LoginPage extends StatefulWidget {
  final bool isShrink;
  const LoginPage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AnimatedScaleScreenWidget<LoginPage> {
  bool _showOverlay = false;
  late AnimationController? overlayController;
  late Animation<double>? overlayAnimation;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    isShrink = widget.isShrink;
    overlayController = null;
    overlayAnimation = null;
  }

  @override
  void dispose() {
    super.dispose();
    if (!mounted) {
      overlayController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return animatedScaleWidget(
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Login in to start planning your next trip.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_showOverlay == false) {
                        _showOverlay = true;
                        onShrink();

                        if (overlayAnimation == null &&
                            overlayController == null) {
                          overlayController = AnimationController(
                            upperBound: 1.0,
                            duration: const Duration(milliseconds: 500),
                            vsync: this,
                          );

                          overlayAnimation = CurvedAnimation(
                            parent: overlayController!,
                            curve: Curves.easeInExpo,
                          );

                          // overlayController!.addStatusListener((status) {
                          //   if (status == AnimationStatus.forward) {
                          //   } else if (status == AnimationStatus.reverse) {
                          //   } else if (status == AnimationStatus.completed) {
                          //     setState(() {});
                          //   } else if (status == AnimationStatus.dismissed) {
                          //     setState(() {});
                          //   } else {}
                          // });
                        }

                        showLoginOverlay(
                            controller: overlayController!,
                            context: context,
                            entry: _overlayEntry,
                            onTap: () {
                              onShrink();
                              _showOverlay = false;
                            }).whenComplete(() => overlayController!.forward());
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: controller!.value * 35,
                      ),
                      child: const SizedBox(
                        height: 60,
                        child: Card(
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.20),
                    Colors.grey.withOpacity(0.1),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ExtraInfoItem.items.map((item) {
                Widget rowItem = TextButton(
                  onPressed: () => item.onTap(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.label,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          item.icon,
                        ],
                      ),
                    ),
                  ),
                );
                if (ExtraInfoItem.items.indexOf(item) !=
                    ExtraInfoItem.items.length - 1) {
                  return Column(
                    children: [
                      rowItem,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  );
                }
                return rowItem;
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
