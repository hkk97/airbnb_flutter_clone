import 'package:airbandb/ui/common/model/base_model.dart';

class DiscoverModel extends DescriptionBaseModel {
  static String assertPath = 'assets/discover_things/';

  DiscoverModel._(String label, String assetImage, String description)
      : super(label, assertPath + assetImage, description: description);

  static final DiscoverModel _experiences = DiscoverModel._(
    'Experiences',
    'experiences.webp',
    'Find unforgettable activities near you.',
  );
  static final DiscoverModel _onlineExperiences = DiscoverModel._(
    'Online Experiences',
    'online_experiences.webp',
    'Live, interactive activities led by Hosts',
  );
  static final DiscoverModel _featuredCollection = DiscoverModel._(
    'Featured collection: Wanderlust',
    'featured_collection.webp',
    'Travel form home with Online Experiences.',
  );

  static List<DiscoverModel> items = [
    _experiences,
    _onlineExperiences,
    _featuredCollection,
  ];
}
