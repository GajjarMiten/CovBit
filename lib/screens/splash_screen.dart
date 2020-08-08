
import 'package:Monks/provider/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      if (auth.status == Status.Uninitialized) {
        print("loading jdsjdji");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoadingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Text("splash"),);
  }
}
