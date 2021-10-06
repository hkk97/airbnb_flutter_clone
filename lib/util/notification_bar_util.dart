import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> changeNotificationBarColor(
  Color colors, {
  Brightness? iconBrightness,
}) async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: colors, statusBarIconBrightness: iconBrightness),
  );
}
