import 'package:airbandb/ui/common/model/base_model.dart';

class LivingModel extends BaseModel {
  static String assertPath = 'assets/live_anywhere/';

  LivingModel._(String label, String assetImage)
      : super(label, assertPath + assetImage);

  static final LivingModel _outdoorGetaways = LivingModel._(
    'Outdoor getaways',
    'outdoor_getaways.webp',
  );
  static final LivingModel _uniqueStays = LivingModel._(
    'Unique stays',
    'unique_stays.webp',
  );
  static final LivingModel _entireHome = LivingModel._(
    'Entire homes',
    'entire_homes.webp',
  );
  static final LivingModel _petsAllowed = LivingModel._(
    'Pets allowed',
    'pets_allowed.webp',
  );

  static List<LivingModel> items = [
    _outdoorGetaways,
    _uniqueStays,
    _entireHome,
    _petsAllowed,
  ];
}
