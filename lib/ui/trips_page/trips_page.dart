import 'package:flutter/material.dart';
import 'package:airbandb/ui/common/animated_scale_screen_widget.dart';
import 'package:airbandb/ui/login_page/login_overlay_widget.dart';

class TripsPage extends StatefulWidget {
  final bool isShrink;
  const TripsPage({Key? key, required this.isShrink}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends AnimatedScaleScreenWidget<TripsPage> {
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
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Trips",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  const Text(
                    "No trips yet",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "When you're ready to plan your next trip, we're here to help.",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: SizedBox(
                        height: 55,
                        width: 125,
                        child: Card(
                          margin: EdgeInsets.all(0),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
