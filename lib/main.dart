import 'package:flutter/material.dart';
// TODO: firebase - Uncomment after setting up Firebase
// import 'package:firebase_core/firebase_core.dart';
import 'package:rtc_mobile/ui/presenters/rtc_app/rtc_app.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: firebase - Uncomment after setting up Firebase
  // await Firebase.initializeApp();
  await initLocator();

  printAppSignature();

  runApp(const RtcApp());
}

void printAppSignature() async {
  final signature = await SmsAutoFill().getAppSignature;
  print("App Signature: $signature");
}
