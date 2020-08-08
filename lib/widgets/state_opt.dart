
import 'package:Monks/model/state_model.dart';
import 'package:Monks/provider/state_provider.dart';
import 'package:Monks/services/CovidAPI_india.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class StateOpt extends StatefulWidget {
  @override
  _StateOptState createState() => _StateOptState();
}

class _StateOptState extends State<StateOpt> {
  final CovidApiInd api = GetIt.I<CovidApiInd>();

  static List<dynamic> countriesData;
  static List<StateModel> countries;

  static Map<String, String> countryMap = {};

  String initialValue = "10";

  @override
  void initState() {
    super.initState();
    print("hellp");
    api.getStateData().then((value) {
      setState(() {
        countriesData = value.body[1]['state_data'];
        countries = countriesData
            .map((e) => StateModel.fromJson(e, countriesData.indexOf(e)))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<StateProvider>(context);
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Color(0xFFE5E5E5),
          ),
        ),
        child: (countries != null)
            ? Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: initialValue,
                      items: countries.map<DropdownMenuItem<String>>((country) {
                        // countryMap[country.value] = country.name;
                        return DropdownMenuItem<String>(
                          value: country.value.toString(),
                          child: Text(
                            country.name,
                            style: TextStyle(
                                fontFamily: "fedroka",
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          initialValue = value;
                          data.setStateCode(value);
                        });
                      },
                    ),
                  ),
                ],
              )
            : JumpingDotsProgressIndicator(
                fontSize: 35,
              ));
  }
}
