class IndiaModel {
  final String name;
  final String code;
  final String delta_change_active_cases;
  final String death_cases;
  final String confirmed_cases;
  final String active_rate;
  final String active_case;

  IndiaModel({
    this.name,
    this.code,
    this.delta_change_active_cases,
    this.death_cases,
    this.confirmed_cases,
    this.active_rate,
    this.active_case,
  });

  factory IndiaModel.fromJson(Map<dynamic, dynamic> data) {
    return IndiaModel(name: data["name"], code: data["alpha2"]);
  }
}
