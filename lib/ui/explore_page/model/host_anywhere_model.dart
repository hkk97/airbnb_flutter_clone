import 'package:airbandb/ui/common/model/base_model.dart';

class HostAnyWhereModel extends SignBaseModel {
  static String assertPath = 'assets/try_host/host_anywhere/';

  HostAnyWhereModel._(
      String label, String assetImage, String description, String signImage)
      : super(
          label,
          assertPath + assetImage,
          description,
          signImage: assertPath + signImage,
        );

  static final HostAnyWhereModel _milan = HostAnyWhereModel._(
    'Host in Milan',
    'milan.webp',
    'Hosting my studio changed \tmy life and gifted me with \tmemorable experiences and \tpeople',
    'milan_sign.webp',
  );
  static final HostAnyWhereModel _atlanta = HostAnyWhereModel._(
    'Host in Altanta',
    'atlanta.webp',
    'Hosting my home allowed \tme to become an \tentrepreneur and laid down a \tpath to fiancial freedom',
    'atlanta_sign.webp',
  );
  static final HostAnyWhereModel _palombaraSabina = HostAnyWhereModel._(
    'Host in Palombara Sabina',
    'palombara_sabina.webp',
    "We're able to keep our \tculture alive by hosting our \tpasta-making experience.",
    'palombara_sabina_sign.webp',
  );

  static final HostAnyWhereModel _chiangMai = HostAnyWhereModel._(
    'Host in Chiang Mai',
    'chiang_mai.webp',
    'Airbnb has allowed me to \tcreate my own job doing \twhat I love - taking care of \tguests',
    'chiang_mai_sign.webp',
  );

  static final HostAnyWhereModel _wadiRum = HostAnyWhereModel._(
    'Host in Wadi Rum',
    'wadi_rum.webp',
    'Hosting my Bedouin tent has \tintroduced me to people \taround the world.',
    'wadi_rum_sign.webp',
  );

  static final HostAnyWhereModel _paraty = HostAnyWhereModel._(
    'Host in Paraty',
    'paraty.webp',
    'I love hosting my eco-home \tso people can connect with \tnature and their loved ones.',
    'paraty_sign.webp',
  );

  static List<HostAnyWhereModel> items = [
    _milan,
    _atlanta,
    _palombaraSabina,
    _chiangMai,
    _wadiRum,
    _paraty,
  ];
}
