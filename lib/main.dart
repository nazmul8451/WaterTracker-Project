
import 'package:device_preview/device_preview.dart';
import 'package:digitawatertracker/User_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


//All Package imported


void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        home:UserScreen() ,
      ), // runApp এর ভিতরে DevicePreview
    ),
  );
}