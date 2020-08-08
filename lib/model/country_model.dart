class CountryModel {
  final String name;
  final String code;

  CountryModel({
    this.name,
    this.code,
  });

  factory CountryModel.fromJson(Map<dynamic, dynamic> data) {
    return CountryModel(name: data["name"], code: data["alpha2"]);
  }
}
