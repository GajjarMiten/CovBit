
import 'package:Monks/helpers/bgcolorTween.dart';
import 'package:Monks/helpers/style.dart';
import 'package:Monks/provider/bluetooth.dart';
import 'package:Monks/widgets/custom_text.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme.dart';


class CovidScanner extends StatefulWidget {
  @override
  _CovidScannerState createState() => _CovidScannerState();
}

class _CovidScannerState extends State<CovidScanner> {
  BlueToothProvider blue;

  int device = 0;

  bool isScannig = true;

  @override
  Widget build(BuildContext context) {
    blue = Provider.of<BlueToothProvider>(context);
    device = blue.devices.length;
    return Material(
      child: blue.isOn
          ? AnimatedContainer(
              color: bgTween
                  .evaluate(AlwaysStoppedAnimation((device >= 1) ? 1.0 : 0.0)),
              duration: Duration(milliseconds: 700),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Image.asset(
                        //   "assets/images/plp.png",
                        //   width: 100,
                        // ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                        (device == 0) ? "You are safe" : "You might be in risk",
                        style: GoogleFonts.fredokaOne(
                            color: Colors.white, fontSize: 30)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                          text: "People Near You \n" + device.toString(),
                          size: 24,
                          weight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CustomText(
                    //     text: blue.devices.toString(),
                    //     size: 18,
                    //     weight: FontWeight.w300,
                    //     color: grey,
                    //   ),
                    // ),
                    SizedBox(height: 5),
                    SizedBox(
                        width: 200,
                        height: 200,
                        child: FlareActor(
                          'assets/flare/b2.flr',
                          animation: 'play',
                          isPaused: !isScannig,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        blue.searchForDevices();
                      },
                      color: MyColors.primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Text(
                          "Scan Nearby Users",
                          style: GoogleFonts.fredokaOne(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/off.png",
                      width: 160,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Bluetooth is turned off, please turn on the bluetooth and click on 'refresh'",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: grey),
                  ),
                ),
                FlatButton.icon(
                    onPressed: () {
                      blue.turnOn();
                    },
                    icon: Icon(Icons.refresh),
                    label: CustomText(text: "refresh")),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
    );
  }
}
