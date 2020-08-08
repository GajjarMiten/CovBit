class StateModel {
  final int active;
  final double active_rate;
  final int confirmed;
  final double death_rate;
  final int death;
  final int recovered;
  final double recovered_rate;
  final String name;
  final int value;

  StateModel(
      {this.active,
      this.active_rate,
      this.confirmed,
      this.death_rate,
      this.death,
      this.recovered,
      this.recovered_rate,
      this.name,
      this.value});

  factory StateModel.fromJson(Map<String,dynamic> data ,int index){

      return StateModel(
        active: data['active'],
        active_rate: data['active_rate']*1.0,
        confirmed: data['confirmed'],
        death_rate: data['death_rate']*1.0,
        death: data['deaths'],
        recovered: data['recovered'],
        recovered_rate: data['recovered_rate']*1.0,
        name: data['state'],
        value: index
      );


  }

}
