
import 'package:Monks/pages/login_page.dart';
import 'package:Monks/provider/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Homepage.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (auth.logedIn) {
      print("loading hh");
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
      });
    } else {
      print("loading");
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
      });
    }
    return Material(
      child: Text("loading"),
    );
  }
}
