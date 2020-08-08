import 'dart:async';
import 'package:Monks/helpers/screen_navigation.dart';
import 'package:Monks/helpers/user.dart';
import 'package:Monks/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Homepage.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  // Firestore _firestore = Firestore.instance;
  UserServices _userServicse = UserServices();
  UserModel _userModel;
  TextEditingController phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool firstOpen;
  bool logedIn;
  bool loading = false;
  bool bluetoothSet;
  String bluetoothId;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;
  FirebaseAuth get instance => _auth;

  TextEditingController address = TextEditingController();

  AuthProvider.initialize() {
    readPrefs();
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> readPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstOpen = prefs.getBool('firstOpen') ?? true;
    logedIn = prefs.getBool('logedIn') ?? false;
    bluetoothId = prefs.getString('bluetoothId')??null;
    address.text = bluetoothId;


    if (!logedIn) {
      _status = Status.Unauthenticated;
    } else {
      _user = await _auth.currentUser();
      _userModel = await _userServicse.getUserById(_user.uid);
      if (_userModel != null) {
        if (_userModel.bluetoothAddress.isNotEmpty) {
          await prefs.setBool("bluetoothSet", true);
        }
      }
      _status = Status.Authenticated;
    }

    bluetoothSet = prefs.getBool('bluetoothSet') ?? false;

    if (firstOpen) {
      await prefs.setBool("firstOpen", false);
    }
    notifyListeners();
  }

// ! PHONE AUTH
  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      // smsOTPDialog(context).then((value) {
      //   print('sign in');
      // });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: number.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
    } catch (e) {
      handleError(e, context);
      errorMessage = e.toString();
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> verifyOTP(BuildContext context, {String otp}) async {
    this.smsOTP = otp;
    loading = true;
    notifyListeners();
    _auth.currentUser().then((user) async {
      if (user != null) {
        _userModel = await _userServicse.getUserById(user.uid);
        if (_userModel == null) {
          _createUser(id: user.uid, number: user.phoneNumber);
        }

        loading = false;
        notifyListeners();
      } else {
        loading = true;
        notifyListeners();

        signIn(context);
      }
    });
    return loading;
  }

  signIn(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("logedIn", true);
      logedIn = true;
      if (user != null) {
        _userModel = await _userServicse.getUserById(user.user.uid);
        if (_userModel == null) {
          _createUser(id: user.user.uid, number: user.user.phoneNumber);
        } else {
          if (_userModel.bluetoothAddress != null) {
            await prefs.setBool("bluetoothSet", true);
          }
        }

        loading = false;
        Navigator.of(context).pop();
        if (bluetoothSet) {
          changeScreenReplacement(context, HomePage());
        } else {
          changeScreenReplacement(context, HomePage());
        }
      }
      loading = false;

      Navigator.of(context).pop();
      changeScreenReplacement(context, HomePage());
      notifyListeners();
    } catch (e) {
      handleError(e, context);
    }
  }

  handleError(error, BuildContext context) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        errorMessage = 'Invalid Code';
        Navigator.of(context).pop();
        verifyOTP(context).then((value) {
          print('sign in');
        });
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  void _createUser({String id, String number}) {
    _userServicse.createUser({
      "id": id,
      "number": number,
      "closeContacts": [],
      "bluetoothAddress": ""
    });
  }

  Future<void> setBluetoothAddress({String id, String bluetoothAddress}) async {
    if (_userModel == null) {
      _createUser(id: _user.uid, number: _user.phoneNumber);
    }
    updateUser({"id": id, "bluetoothAddress": bluetoothAddress});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bluetoothId = bluetoothAddress;
    prefs.setString('bluetoothId', bluetoothAddress);
    await prefs.setBool("bluetoothSet", true);
    notifyListeners();
  }

  void updateUser(Map<String, dynamic> values) {
    _userServicse.updateUserData(values);
  }
}
