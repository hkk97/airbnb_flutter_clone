import 'package:airbandb/ui/common/model/base_model.dart';

class DemonstrationModel extends BaseModel {
  static String assertPath = 'assets/try_host/demonstration/';

  DemonstrationModel._(String label, String assetImage)
      : super(label, assertPath + assetImage);

  static final DemonstrationModel _philadelphia = DemonstrationModel._(
    'Host in Philadelphia',
    // 0 -2
    'philadelphia_sign.webp',
  );
  static final DemonstrationModel _mumbai = DemonstrationModel._(
    'Host in Mumbai', // 2 - 3
    'mumbai_sign.webp',
  );
  static final DemonstrationModel _johannesburg = DemonstrationModel._(
    'Host in Johannesburg', //3 - 5
    'johannesburg_sign.webp',
  );

  static final DemonstrationModel _mexicoCity = DemonstrationModel._(
    'Host in Mexico City', //3 - 5
    'mexicoCity_sign.webp',
  );

  static List<DemonstrationModel> items = [
    _philadelphia,
    _mumbai,
    _johannesburg,
    _mexicoCity,
  ];
}
