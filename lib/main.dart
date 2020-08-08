import 'package:Monks/services/CovidAPI.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'services/CovidAPI_india.dart';
import 'package:Monks/constant.dart';


void setupLocator() {
  GetIt.I.registerSingleton(CovidAPI.create());
  GetIt.I.registerSingleton(CovidApiInd.create());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CovBit',
      home:Scaffold(
        body: Text("hello"),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
      ),
    );
  }
}
