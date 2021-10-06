import 'package:airbandb/ui/explore_page/host_overlay_widget/host_overlay_manager.dart';
import 'package:flutter/material.dart';
import 'package:airbandb/ui/common/animated_scale_widget.dart';
import 'package:airbandb/ui/explore_page/host_overlay_widget/hosting_overlay_widget.dart';

class TryHostWidget extends StatefulWidget {
  const TryHostWidget({Key? key}) : super(key: key);

  @override
  _TryHostWidgetState createState() => _TryHostWidgetState();
}

class _TryHostWidgetState extends AnimatedScaleButtonWidget<TryHostWidget> {
  bool _showOverlay = false;
  late AnimationController? overlayController;
  late AnimationController? nestedOverlayController;

  late Animation<double>? overlayAnimation;
  late Animation<double>? nestedOverlayAnimation;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    overlayController = null;
    overlayAnimation = null;
    nestedOverlayController = null;
    nestedOverlayAnimation = null;
  }

  @override
  void dispose() {
    super.dispose();
    if (!mounted) {
      overlayController!.dispose();
      nestedOverlayController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: animatedScaleWidget(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: GestureDetector(
              onTap: () async {
                if (_showOverlay == false) {
                  _showOverlay = true;
                  onShrink();

                  if (overlayAnimation == null &&
                      overlayController == null &&
                      nestedOverlayAnimation == null &&
                      nestedOverlayController == null) {
                    overlayController = AnimationController(
                      upperBound: 1.0,
                      duration: const Duration(milliseconds: 500),
                      vsync: this,
                    );

                    nestedOverlayController = AnimationController(
                      upperBound: 1.0,
                      duration: const Duration(milliseconds: 500),
                      vsync: this,
                    );

                    overlayAnimation = CurvedAnimation(
                      parent: overlayController!,
                      curve: Curves.easeInExpo,
                    );

                    nestedOverlayAnimation = CurvedAnimation(
                      parent: nestedOverlayController!,
                      curve: Curves.easeInExpo,
                    );
                  }

                  HostOverlayManager().init(context).whenComplete(
                    () {
                      showHostingOverlay(
                        controller: overlayController!,
                        nestedController: nestedOverlayController!,
                        nestedAnimation: nestedOverlayAnimation!,
                        context: context,
                        entry: _overlayEntry,
                        onTap: () {
                          onShrink().whenComplete(() {
                            _showOverlay = false;
                          });
                        },
                      ).whenComplete(
                        () {
                          overlayController!.forward().whenComplete(() {});
                        },
                      );
                    },
                  );
                }
              },
              onLongPressStart: (detail) {
                onShrink();
              },
              onLongPressEnd: (detail) {
                onShrink();
              },
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/try_host/hosting.webp'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "Try hosting",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Earn extra income and unlock new",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            "opportunities by sharing",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            "your space.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 18.0),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Text(
                                "Learn More",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
