import 'package:flutter/material.dart';

class ExtraInfoItem {
  final String label;
  final Icon icon;
  final Function onTap;

  ExtraInfoItem._(this.label, this.icon, this.onTap);

  static final ExtraInfoItem _setting = ExtraInfoItem._(
    'Settings',
    const Icon(
      Icons.settings,
    ),
    () {
      debugPrint("Route to Settings Page");
    },
  );
  static final ExtraInfoItem _help = ExtraInfoItem._(
    'Get help',
    const Icon(Icons.help_outline),
    () {
      debugPrint("Route to Helping Page");
    },
  );
  static final ExtraInfoItem _host = ExtraInfoItem._(
    'Learn about hosting',
    const Icon(Icons.add_business_outlined),
    () {
      debugPrint("Route to Hosting Page");
    },
  );

  static List<ExtraInfoItem> items = [
    _setting,
    _help,
    _host,
  ];
}
