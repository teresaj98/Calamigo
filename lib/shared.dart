import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'intro.dart';
import 'package:calamigo/contact.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds:6), () {});
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Intro()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Intro()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context){
    checkFirstSeen();
    }

  @override
  Widget build(BuildContext context) {
  
    return new Scaffold(
      backgroundColor:Colors.grey[900],
      body: SpinKitDoubleBounce(
              color: Colors.teal[600],
              size:75.0,
             
            ),
      
    );
  }
}