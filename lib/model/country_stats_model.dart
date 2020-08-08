class CountryStatsModel {
  final int cases;
  final int death;
  final int recoverd;
  final String country;
  final String dateTime;

  CountryStatsModel(
      {this.cases, this.death, this.recoverd, this.country, this.dateTime});

  factory CountryStatsModel.fromJson(Map<dynamic, dynamic> data) {
    return CountryStatsModel(
      cases: data["cases"],
      recoverd: data["recovered"],
      death: data["deaths"],
      country: data["country"],
      dateTime: data["last_update"],
    );
  }
}
