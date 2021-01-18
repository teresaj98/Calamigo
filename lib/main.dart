

import 'package:flutter/material.dart';
import 'contact.dart';
import 'shared.dart';
import 'setting.dart';


void main() => runApp(
  MaterialApp(
    initialRoute:'/',
    routes: {
     '/':(context) => Splash(),
     '/contacts':(context) => AccessContacts(),
     '/update':(context) => Updaten(),
    
   },
  ),
);


