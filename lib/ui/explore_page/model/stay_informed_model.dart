import 'package:airbandb/ui/common/model/base_model.dart';

class BaseTextModel {
  final String title;
  final String subTitle;
  BaseTextModel(this.title, this.subTitle);
}

class StayInformedModel {
  final String section;
  final BaseTextModel fist;
  final BaseTextModel second;
  final BaseTextModel third;

  StayInformedModel._(this.section, this.fist, this.second, this.third);

  static final StayInformedModel _guests = StayInformedModel._(
    'For guests',
    BaseTextModel('Our COVID-19 response', 'Health and safety updates'),
    BaseTextModel("Cancellation options", "Learn what's covered"),
    BaseTextModel('Help Centre', 'Get support'),
  );
  static final StayInformedModel _hosts = StayInformedModel._(
    'For hosts',
    BaseTextModel('Message from Brian Chesky', 'Hear from our CEO'),
    BaseTextModel('Resources for hosting', "What's affected by COVID-19"),
    BaseTextModel('Host Afghan refugees', 'Learn how to help'),
  );
  static final StayInformedModel _covid19Responders = StayInformedModel._(
    'For COVID-19 responders',
    BaseTextModel('Frontline stays', 'Learn about our programme'),
    BaseTextModel('Sign up', 'Check for hosing options'),
    BaseTextModel('Make a donation', 'Support nonprofit organisations'),
  );
  static final StayInformedModel _more = StayInformedModel._(
    'More',
    BaseTextModel('Airbnb Newsroom', 'Latest announcements'),
    BaseTextModel(
        "Watch 'Made Possible by Hosts'", 'Short films about Airbnb trips'),
    BaseTextModel('Airbnb 2021', 'Introducing 100+ upgrades'),
  );

  static List<StayInformedModel> items = [
    _guests,
    _hosts,
    _covid19Responders,
    _more,
  ];
}
