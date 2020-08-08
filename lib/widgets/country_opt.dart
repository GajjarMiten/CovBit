
import 'package:Monks/model/country_model.dart';
import 'package:Monks/services/CovidAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:Monks/provider/country_providers.dart';

class CountryDropDown extends StatefulWidget {
  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  final CovidAPI api = GetIt.I<CovidAPI>();

  static List<dynamic> countriesData;
  static List<CountryModel> countries;

  static Map<String, String> countryMap = {};

  String initialValue = "IN";

  @override
  void initState() {
    super.initState();

    api.getCountries().then((value) {
      setState(() {
        countriesData = value.body;
        countries = countriesData.map((e) => CountryModel.fromJson(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CountryProvider>(context);
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
                      countryMap[country.code] = country.name;
                      return DropdownMenuItem<String>(
                        value: country.code,
                        child: Text(country.name,style: TextStyle(fontFamily: "fedroka",fontWeight: FontWeight.normal),),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        initialValue = value;
                        data.setCountry(countryMap[value].toString());
                        data.setCountryCode(value.toString());
                      });
                    },
                  ),
                ),
              ],
            )
          : JumpingDotsProgressIndicator(
            fontSize: 35,
          )
    );
  }
}
