import 'package:airbandb/util/notification_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HostOverlayManager {
  HostOverlayManager._internal();
  factory HostOverlayManager() => _manager;
  static final _manager = HostOverlayManager._internal();

  late VideoPlayerController? _videoController1;
  late VideoPlayerController? _videoController2;

  VideoPlayerController videoController1() => _videoController1!;
  VideoPlayerController videoController2() => _videoController2!;

  late GlobalKey? _tryHostKey;
  GlobalKey tryHostKey() => _tryHostKey!;

  double _verticleOffset = 0;
  double verticleOffset() => _verticleOffset;

  late ScrollController? _scrollController;
  late ValueNotifier<int>? _subTitleNotifier;
  late ValueNotifier<int>? _anyHostNotifier;
  late ValueNotifier<bool>? _backgroundNotifier;
  late ValueNotifier<bool>? _playNotifier1;
  late ValueNotifier<bool>? _playNotifier2;
  late ValueNotifier<List>? _jointNotifier;
  late ValueNotifier<double>? _verticalOffsetNotifier;

  ScrollController scrollController() => _scrollController!;

  ValueNotifier<int> subTitleNotifier() => _subTitleNotifier!;
  ValueNotifier<int> anyHostNotifier() => _anyHostNotifier!;
  ValueNotifier<bool> backgroundNotifier() => _backgroundNotifier!;
  ValueNotifier<bool> playNotifier1() => _playNotifier1!;
  ValueNotifier<bool> playNotifier2() => _playNotifier2!;
  ValueNotifier<List> jointNotifier() => _jointNotifier!;
  ValueNotifier<double> verticalOffsetNotifier() => _verticalOffsetNotifier!;

  late Future<void>? _initializeVideoPlayerFuture1;
  late Future<void>? _initializeVideoPlayerFuture2;

  Future<void> initializeVideoPlayerFuture1() => _initializeVideoPlayerFuture1!;
  Future<void> initializeVideoPlayerFuture2() => _initializeVideoPlayerFuture2!;

  void updateOffset() {
    _verticleOffset = _scrollController!.offset;
  }

  Future<void> init(context) async {
    _scrollController = ScrollController(initialScrollOffset: 0);
    _subTitleNotifier = ValueNotifier(0);
    _anyHostNotifier = ValueNotifier(0);
    _backgroundNotifier = ValueNotifier(false);
    _playNotifier1 = ValueNotifier(true);
    _playNotifier2 = ValueNotifier(true);
    _jointNotifier = ValueNotifier([false, Colors.white]);
    _verticalOffsetNotifier = ValueNotifier(0);
    _tryHostKey = GlobalKey();

    _videoController1 = VideoPlayerController.asset(
      'assets/try_host/demonstration/host_demostrate.mp4',
    );
    _videoController2 = VideoPlayerController.asset(
      'assets/try_host/demonstration/try_host.mp4',
    );
    _initializeVideoPlayerFuture1 = _videoController1!.initialize();
    _initializeVideoPlayerFuture2 = _videoController2!.initialize();
    _videoController1!.setLooping(false);
    _videoController2!.setLooping(false);
    _videoController2!.addListener(() {
      if (_videoController2!.value.isPlaying &&
          _playNotifier2!.value == false) {
        _playNotifier2!.value = true;
      } else if (!_videoController2!.value.isPlaying &&
          _playNotifier2!.value == true) {
        _playNotifier2!.value = false;
      }
    });
    _videoController1!.addListener(() {
      int second = _videoController1!.value.position.inSeconds;

      if (second < 2 || (second > 6 && second <= 7)) {
        _subTitleNotifier!.value = 0;
      } else if (second >= 2 && second < 3) {
        _subTitleNotifier!.value = 1;
      } else if (second >= 4 && second < 5) {
        _subTitleNotifier!.value = 2;
      } else if (second >= 5 && second <= 6) {
        _subTitleNotifier!.value = 3;
      }
      if (_videoController1!.value.isPlaying &&
          _playNotifier1!.value == false) {
        _playNotifier1!.value = true;
      } else if (!_videoController1!.value.isPlaying &&
          _playNotifier1!.value == true) {
        _playNotifier1!.value = false;
      }
    });
    _videoController1!.play().whenComplete(() => _playNotifier1!.value = true);

    _scrollController!.addListener(() {
      if (!_tryHostKey!.currentContext!.size!.isEmpty) {
        final RenderBox box =
            _tryHostKey!.currentContext!.findRenderObject() as RenderBox;
        final boxOffset = box.localToGlobal(Offset.zero);

        if (boxOffset.dy < MediaQuery.of(context).size.height) {
          if (_videoController2!.value.isPlaying == false &&
              _playNotifier2!.value == false) {
            _videoController2!
                .play()
                .whenComplete(() => _playNotifier2!.value = true);
          }
          _jointNotifier!.value[0] != true
              ? _jointNotifier!.value = [true, Colors.black]
              : null;
        } else {
          _jointNotifier!.value[0] == true
              ? _jointNotifier!.value = [false, Colors.white]
              : null;
        }
      }
    });
  }

  void dispose() {
    _scrollController!.removeListener(() {});
    _videoController2!.removeListener(() {});
    _videoController1!.removeListener(() {});
    _scrollController!.dispose();
    _videoController1!.dispose();
    _videoController2!.dispose();

    _scrollController = null;
    _videoController1 = null;
    _videoController2 = null;
    _scrollController = null;

    _subTitleNotifier!.dispose();
    _anyHostNotifier!.dispose();
    _backgroundNotifier!.dispose();
    _playNotifier1!.dispose();
    _playNotifier2!.dispose();
    _jointNotifier!.dispose();
    _verticalOffsetNotifier!.dispose();

    _subTitleNotifier = null;
    _anyHostNotifier = null;
    _backgroundNotifier = null;
    _playNotifier1 = null;
    _playNotifier2 = null;
    _jointNotifier = null;
    _verticalOffsetNotifier = null;

    _initializeVideoPlayerFuture1 = null;
    _initializeVideoPlayerFuture2 = null;
  }

  Future<void> onShrink(AnimationController controller, bool isShrink) async {
    if (!controller.isAnimating) {
      isShrink = !isShrink;
      isShrink
          ? changeNotificationBarColor(Colors.black,
                  iconBrightness: Brightness.light)
              .whenComplete(() => controller.forward())
              .whenComplete(
                () => _scrollController!.jumpTo(_verticleOffset),
              )
          : controller.reverse().whenComplete(() {
              changeNotificationBarColor(Colors.white,
                  iconBrightness: Brightness.dark);
              _scrollController!.jumpTo(_verticleOffset);
            });
    }
  }
}
