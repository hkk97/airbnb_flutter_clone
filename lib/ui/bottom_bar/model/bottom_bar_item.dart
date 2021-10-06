import 'package:airbandb/ui/common/model/base_model.dart';

class BottomBarItem extends BaseModel {
  static String assertPath = 'assets/icon/';

  BottomBarItem._(String label, String assetImage)
      : super(label, assertPath + assetImage);

  static final BottomBarItem _explore = BottomBarItem._(
    'Explore',
    'search_btn.png',
  );
  static final BottomBarItem _wishlist = BottomBarItem._(
    'Wishlists',
    'heart_icon.png',
  );
  static final BottomBarItem _trips = BottomBarItem._(
    'Trips',
    'airbnb_icon.png',
  );
  static final BottomBarItem _inbox = BottomBarItem._(
    'Inbox',
    'inbox_icon.png',
  );
  static final BottomBarItem _account = BottomBarItem._(
    'Log in',
    'account_icon.png',
  );

  static List<BottomBarItem> items = [
    _explore,
    _wishlist,
    _trips,
    _inbox,
    _account
  ];
}
