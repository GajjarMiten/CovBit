import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';



class Blue extends StatefulWidget {
  @override
  _BlueState createState() =>  _BlueState();
}

class _BlueState extends State<Blue> {
  String _data = '';
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Text(_data)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RaisedButton(child: Text(_scanning ? 'Stop scan' : 'Start scan'), onPressed: () async {
                  try {
                    if(_scanning) {
                      await _bluetooth.stopScan();
                      debugPrint("scanning stoped");
                      setState(() {
                        _data = '';
                      });
                    }
                    else {
                      await _bluetooth.startScan(pairedDevices: false);
                      debugPrint("scanning started");
                      setState(() {
                        _scanning = true;
                      });
                    }
                  } on PlatformException catch (e) {
                    debugPrint(e.toString());
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}