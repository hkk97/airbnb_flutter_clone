class BaseModel {
  final String label;
  final String assetImage;
  BaseModel(this.label, this.assetImage);
}

class DescriptionBaseModel extends BaseModel {
  final String description;
  DescriptionBaseModel(String label, String assetImage,
      {required this.description})
      : super(label, assetImage);
}

class SignBaseModel extends DescriptionBaseModel {
  final String signImage;
  SignBaseModel(String label, String assertImage, String description,
      {required this.signImage})
      : super(label, assertImage, description: description);
}
