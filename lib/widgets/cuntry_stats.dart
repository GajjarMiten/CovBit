import 'package:Monks/model/country_stats_model.dart';
import 'package:Monks/services/CovidAPI.dart';
import 'package:chopper/chopper.dart';
import 'package:Monks/provider/country_providers.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'counter.dart';

class CountryStats extends StatefulWidget {
  @override
  _CountryStatsState createState() => _CountryStatsState();
}

class _CountryStatsState extends State<CountryStats>
    with AutomaticKeepAliveClientMixin {
  final CovidAPI api = GetIt.I<CovidAPI>();

  Future<Response> getData(String country)async{
     var data = await api.getStatusByCountry(country);
     return data;
  }

  // @override
  // void initState() {
    
  //   super.initState();
  //   _future = getData();
  // }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    final data = Provider.of<CountryProvider>(context);

    return FutureBuilder<Response>(
      future: getData(data.getCountryCode),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.body);
          final stats = CountryStatsModel.fromJson(snapshot.data.body);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Case Update\n",
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: stats.dateTime.substring(0, 10),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'fedroka',
                              color: kTextLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      "See details",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 16,
                        color: Color(0xFFB7B7B7).withOpacity(.6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Counter(
                        color: kInfectedColor,
                        number: stats.cases,
                        title: "Infected",
                      ),
                      Counter(
                        color: kDeathColor,
                        number: stats.death,
                        title: "Deaths",
                      ),
                      Counter(
                        color: kRecovercolor,
                        number: stats.recoverd,
                        title: "Recovered",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Spread of Virus",
                      style: kTitleTextstyle,
                    ),
                    Text(
                      "See details",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  height: 178,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/map.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: SizedBox(
            height: 60,
            width: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.orbit,
              // color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
